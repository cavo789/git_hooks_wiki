# git_hooks_wiki

A hook to run concat-md and generate_sidebar when committing a wiki.

![Banner](./banner.svg)

* [Wiki hooks](#wiki-hooks)
* [Author](#author)
* [License](#license)

## Wiki hooks

Copy the three files from the `hooks/wiki` folder in the `.git\hooks` folder of your wiki repository.

The `pre-commit` hook will be called when you'll run a `git commit -m "XXX"` command and will terminate the command when an error ocurred when executing the `pre-commit.ps1` file.

This repository contains three files in the `hooks/wiki` folder:

1. `pre-commit` - The definition of the hook. This file is fired by git when the `git commit` command is executed
2. `pre-commit.cmd` - The hook will run this batch, in charge of the execution of ...
3. `pre-commit.ps1` - The Powershell script that will run actions and return an exit code `0` when everything is going fine; different than `0` if an error has been encountered.

What does `pre-commit.ps1`?

This script will do these actions:

1. Scan the current repository and retrieve all files called `concat-md.cmd`, in all folders (recursively) and for each `concat-md.cmd` script retrieved:
   1. Jump inside the folder where the `concat-md.cmd` is located,
   2. Run the script
   3. Restore the current folder
   4. Check the exit code of the script.
      1. If different than zero, the script stops and the `git commit` action will be denied.
      2. Otherwise continue and process the next occurrence of `concat-md.cmd`
2. Check the presence of the `generate_sidebar.cmd` script in the repository root folder and if there is one, execute the script.

The `git commit` action will fail as soon as one script started by the hook has failed.

## Author

Christophe Avonture

## License

[MIT](LICENSE)
