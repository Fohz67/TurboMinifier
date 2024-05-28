#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: You must specify input and output directories."
    echo "Usage: $0 path/to/input/directory path/to/output/directory"
    exit 84
fi

obfuscate_js() {
    input_file="$1"
    output_file="$2"
    terser "$input_file" -o "$output_file" --compress --mangle
}

minify_html() {
    input_file="$1"
    output_file="$2"
    tr '\n' ' ' < "$input_file" | tr -s ' ' | sed 's/ \+/ /g' | sed 's/> </></g' > "$output_file"
}

minify_css() {
    input_file="$1"
    output_file="$2"
    tr '\n' ' ' < "$input_file" | tr -s ' ' | sed 's/ \+/ /g' | sed 's/; /;/g' | sed 's/ {/{/g' | sed 's/ }/}/g' > "$output_file"
}

process_files() {
    input_dir="$1"
    output_dir="$2"

    find "$input_dir" -type f | while read -r file; do
        relative_path="${file#$input_dir/}"
        output_file="$output_dir/$relative_path"
        output_dir_path=$(dirname "$output_file")

        mkdir -p "$output_dir_path"

        if [[ "$file" == *"script.user.js" ]]; then
            echo "Skipping $file..."
            cp "$file" "$output_file"
            continue
        fi

        case "$file" in
            *.js)
                echo "Obfuscating $file..."
                obfuscate_js "$file" "$output_file"
                ;;
            *.html)
                echo "Minifying HTML $file..."
                minify_html "$file" "$output_file"
                ;;
            *.css)
                echo "Minifying CSS $file..."
                minify_css "$file" "$output_file"
                ;;
            *)
                echo "Copying $file..."
                cp "$file" "$output_file"
                ;;
        esac
    done
}

input_dir="$1"
output_dir="$2"

process_files "$input_dir" "$output_dir"
