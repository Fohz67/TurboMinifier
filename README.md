# TurboMinifier
## Obfuscate and Minify Script


This Bash script processes JavaScript, HTML, and CSS files by obfuscating or minifying them. It traverses a specified input directory, applies the appropriate transformations to the files, and then saves them in an output directory. Files with the `script.user.js` extension are copied as-is without any modifications.

## Prerequisites

- [Terser](https://terser.org/) must be installed for JavaScript obfuscation.

## Usage

1. Clone this repository to your local machine.
2. Ensure that `terser` is installed and available in your PATH.
3. Run the script with the specified input and output directories:

```bash
./obfuscate_minify.sh path/to/input/directory path/to/output/directory
```

## Example

Suppose you have a development directory `dev` containing your source files, and you want to save the processed files in the `public` directory:

```bash
./obfuscate_minify.sh dev public
```

The script will:

- Obfuscate JavaScript files using Terser.
- Minify HTML and CSS files.
- Copy other files without modification.

Files with the `script.user.js` extension will be copied as-is without modification.

## Notes

- The script recursively traverses all files in the input directory.
- Ensure that the input and output paths are correct and exist before running the script.

## Contribution

Contributions are welcome. Feel free to open an issue or a pull request for any improvements or bugs.
