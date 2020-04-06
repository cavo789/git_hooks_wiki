Write-Host ""
Write-Host "Running $($PSCommandPath)`n"  -ForegroundColor Green;

# Scan the entire repository and retrieve any concat-md.cmd scripts
Get-ChildItem -Filter concat-md.cmd -Recurse |
ForEach-Object {

    # Go in his folder
    Push-Location  $_.DirectoryName

    Write-Host "    Running $($_.FullName)`n" -ForegroundColor DarkCyan;

    # Execute the script
    $obj = Start-Process $_.fullname -PassThru -wait
    
    if ($obj.ExitCode -ne 0) {
        Write-Host "        An error $($obj.ExitCode) has occured in $($_.fullname)" -ForegroundColor Red;
        exit $obj.ExitCode
    }

    # Restore the previous folder
    Pop-Location

}

# Run the generate_sidebar script if there is one in the repo root folder
if (Test-Path ".\generate_sidebar.cmd" -PathType Leaf) {
    Write-Host "    Run sidebar`n" -ForegroundColor DarkCyan;
    
    $obj = Start-Process .\generate_sidebar.cmd -PassThru -wait
    
    if ($obj.ExitCode -ne 0) {
        Write-Host "        An error $($obj.ExitCode) has occured in generate_sidebar.cmd`n" -ForegroundColor Red;
        exit $obj.ExitCode
    }
}

# Add new, updated, files
git commit -a -m "concatenate"

# Inform the pre-commit hook of git that everything was fine
exit 0
