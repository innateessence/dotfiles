#!/usr/bin/env bash

# This script converts DNG images to PNG images
# This should work with any raw image format that ImageMagick supports.
# And then compresses the PNG.
#
# This script is the result of trying to figure out how to convert
# Leica Q2 DNG files to PNG and compress them to save disk space
# In a way that can be ran as a cron job on a simple raspberry-pi NAS RAID
# As a self-managed backup solution.
#
# Usage:
#   compress-raw-photos.sh --help
#   compress-raw-photos.sh <filename> <filename> <filename>
#
# You may pass infinite filenames as arguments

function runtime_check(){
    local dependencies
    dependencies=("magick" "optipng")

    for dependency in "${dependencies[@]}"; do
        if [ -z "$(which "$dependency")" ]; then
            echo "$dependency is not installed. Please install it."
            exit 1
        fi
    done

}

function convert_to_png(){
    local input_filename
    local output_filename

    input_filename=$1
    output_filename=$2

    echo "[*] Converting $input_filename to PNG..."
    magick "$input_filename" -auto-orient -strip "$output_filename"
}

function resize_png(){
    local input_filename
    input_filename=$1
    echo "[*] Resizing $input_filename PNG..."

    width=$(magick identify -format "%w" "$input_filename")
    height=$(magick identify -format "%h" "$input_filename")

    if [ -z "$width" ] || [ -z "$height" ]; then
        echo "Could not determine image dimensions."
        exit 1
    fi

    if [ "$width" -lt 1080 ] || [ "$height" -lt 1080 ]; then
        echo "Image is too small."
        exit 1
    fi

    if [ "$width" -eq "$height" ]; then
        echo "[*] Image is square."
        magick "$input_filename" -resize 1080x1080 "$input_filename"
    elif [ "$width" -gt "$height" ]; then
        echo "[*] Image is in landscape mode."
        magick "$input_filename" -resize 1920x1080 "$input_filename"
    elif [ "$height" -gt "$width" ]; then
        echo "[*] Image is in portrait mode."
        magick "$input_filename" -resize 1080x1920 "$input_filename"
    fi
}

function compress_png(){
    local input_filename
    input_filename=$1

    echo "[*] Compressing $input_filename PNG..."

    # magick "$input_filename" \
        #     -depth 24 \
        #     -define png:compression-filter=2 \
        #     -define png:compression-level=9 \
        #     -define png:compression-strategy=1 \
        #     "$input_filename"

    # NOTE: optipng does a better job than me playing with manual PNG compression options
    # It brute-forces the best compression settings for you. Nice.
    optipng "$input_filename" &> /dev/null

}

function crop_png(){
    local input_filename
    input_filename=$1

    echo "[*] Cropping $input_filename PNG..."

    magick "$input_filename" -crop +20+20 "$input_filename"
}

function get_filesize(){
    local filename
    filename=$1
    du -sh "$filename" | cut -f1 | tr -d ' '
}

function convert_and_compress(){
    local input_filename
    local input_filesize
    local output_filename
    local output_filesize

    input_filename=$1
    output_filename="${input_filename%.*}.png"

    input_filesize=$(get_filesize "$input_filename")

    convert_to_png "$input_filename" "$output_filename"
    crop_png "$output_filename"
    resize_png "$output_filename"
    compress_png "$output_filename"

    output_filesize=$(get_filesize "$output_filename")

    echo "[*] Converted and Compressed $input_filesize to $output_filesize"
}

function copy_timestamp_metdata(){
    local input_filename
    local output_filename

    local timestamp

    input_filename=$1
    output_filename="${input_filename%.*}.png"

    timestamp=$(exiftool -d "%Y:%m:%d %H:%M:%S%z" -DateTimeOriginal -s3 "$input_filename")

    if [ -z "$timestamp" ]; then
        echo "Could not extract timestamp from $input_filename"
        exit 1
    fi

    exiftool -overwrite_original -ModifyDate="$timestamp" "$output_filename"
    exiftool -overwrite_original -FileModifyDate="$timestamp" "$output_filename"
}

function parse_args(){
    while [ ${#} != 0 ]; do
        case "${1}" in
            -h | --help)
                echo "Usage: compress-raw-photos.sh <filename> <filename> ... [options]";
                echo "Options:";
                echo "  -h, --help    Print this help message and exit";
                echo "  -d, --delete  Delete the original files after converting and compressing";
                echo
                echo "You may pass between 1 and an infinite number of filenames as arguments";
                exit 0 ;;
            -d | --delete)
                delete_files=true;
                shift ;;
            *)
                if [ ! -f "$1" ]; then
                    echo "File: $1 does not exist!"
                    exit 1
                else
                    files+=("$1");
                    shift;
                fi ;;
        esac
    done
}

files=()
delete_files=false

function Main(){

    runtime_check
    parse_args "$@"

    for file in "${files[@]}"; do
        convert_and_compress "$file"
        copy_timestamp_metdata "$file"
        if [ "$delete_files" = true ]; then
            echo "[*] Deleting $file"
            rm "$file"
        fi
    done
}

Main "$@"
