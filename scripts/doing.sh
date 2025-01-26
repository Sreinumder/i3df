#!/bin/bash

# path to the folder with all files
DOING_PATH="$HOME/.doing"
# first stored argument in do file (index of file to show do-line from)
DOING_FILE_INDEX=$(sed -n '1p' "$DOING_PATH/do")
# doing-file index needs to be a number
if ! [[ "$DOING_FILE_INDEX" =~ ^[0-9]+$ ]]; then
    echo "Invalid index in do file."
    exit 1
fi
# second stored argument in do file (flag for showing/notshowing doline)
SHOW_FLAG=$(sed -n '2p' "$DOING_PATH/do")
# actual do-file with line number and do list
DOING_FILE="$DOING_PATH/do-$DOING_FILE_INDEX"
# DONE_FILE for completed tasks
DONE_FILE="$DOING_PATH/done-$DOING_FILE_INDEX"

# Check if the file exists
if [ ! -f "$DOING_FILE" ]; then
    echo "File not found: $DOING_FILE"
    exit 1
fi

# Get the total number of lines in the file
TOTAL_LINES=$(wc -l < "$DOING_FILE")

# Read the current line number from the first line of the file (after the index line)
LINE_NUMBER=$(head -n 1 "$DOING_FILE")

# If the first line is not a valid number, set it to 2 or
# there is less than 2 total lines
if ! [[ "$LINE_NUMBER" =~ ^[0-9]+$ ]] || [ "$LINE_NUMBER" -lt 2 ] || [ "$TOTAL_LINES" -lt 2 ] ; then
    LINE_NUMBER=2
    # Update the file with the new line number
    sed -i "1s/^.*$/$LINE_NUMBER/" "$DOING_FILE"
fi


# Ensure the line number is within valid range (2 to the last line)
if [ "$LINE_NUMBER" -gt "$TOTAL_LINES" ]; then
    LINE_NUMBER="$TOTAL_LINES"
fi

case "$1" in
    "next-do")
        # Increment line number, ensure it stays within bounds
        if [ "$LINE_NUMBER" -lt "$TOTAL_LINES" ]; then
            LINE_NUMBER=$((LINE_NUMBER + 1))
        fi
        sed -i "1s/^.*$/$LINE_NUMBER/" "$DOING_FILE"
        ;;
    "prev-do")
        # Decrement line number, ensure it stays within bounds
        if [ "$LINE_NUMBER" -gt 2 ]; then
            LINE_NUMBER=$((LINE_NUMBER - 1))
            sed -i "1s/^.*$/$LINE_NUMBER/" "$DOING_FILE"
        fi
        ;;
    "show")
        if [ "$TOTAL_LINES" -le 1 ]; then
            echo "$DOING_FILE_INDEX全部終わった"
            exit 0
        fi
        # If the flag is 0, exit early and echo ""
        if [ "$SHOW_FLAG" -eq 0 ]; then
            echo ""
            exit 0
        fi
        # Display the current task based on the line number
        CURRENT_LINE=$(sed -n "${LINE_NUMBER}p" "$DOING_FILE")
        echo "今 $((DOING_FILE_INDEX + 1)).$((LINE_NUMBER - 1)).$CURRENT_LINE"
        ;;
    "toggle-show")
        if [ "$SHOW_FLAG" -eq 0 ]; then
            sed -i "2s/^.*$/1/" "$DOING_PATH/do"
        else
            sed -i "2s/^.*$/0/" "$DOING_PATH/do"
        fi
        exit 0
        ;;
    "next-file")
        # Increment the file index, ensure it's >= 0
        DOING_FILE_INDEX=$((DOING_FILE_INDEX + 1))
        DOING_FILE="$HOME/.doing/do-$DOING_FILE_INDEX"
        if [ ! -f "$DOING_FILE" ]; then
            exit 0
        fi
        sed -i "1s/^.*$/$DOING_FILE_INDEX/" "$DOING_PATH/do"
        ;;
    "prev-file")
        # Decrement the file index, ensure it's >= 0
        if [ "$DOING_FILE_INDEX" -gt 0 ]; then
            DOING_FILE_INDEX=$((DOING_FILE_INDEX - 1))
        fi
        DOING_FILE="$HOME/.doing/do-$DOING_FILE_INDEX"
        sed -i "1s/^.*$/$DOING_FILE_INDEX/" "$DOING_PATH/do"
        ;;
    "done")
        if [ ! -f "$DONE_FILE" ]; then
            touch "$DONE_FILE"
        fi
        if [ "$TOTAL_LINES" -lt 2 ] || [ "$LINE_NUMBER" -lt 2 ]; then
            exit 0
        fi
        # Get the current task
        CURRENT_LINE=$(sed -n "${LINE_NUMBER}p" "$DOING_FILE")
        # Add the task to DONE_FILE with the current date
        echo "$CURRENT_LINE | $(date)" | cat - "$DONE_FILE" > temp && mv temp "$DONE_FILE"
        # Remove the task from the DOING_FILE
        sed -i "${LINE_NUMBER}d" "$DOING_FILE"
        # Recalculate TOTAL_LINES
        TOTAL_LINES=$(wc -l < "$DOING_FILE")
        # If the current line was the last one, update LINE_NUMBER to reflect the new last line
        if [ "$LINE_NUMBER" -eq "$TOTAL_LINES" ]; then
            LINE_NUMBER=$((LINE_NUMBER - 1))
            # Update the line number at the top of the DOING_FILE
            sed -i "1s/^.*$/$LINE_NUMBER/" "$DOING_FILE"
        fi
        ;;
    "undo")
        if [ ! -f "$DONE_FILE" ] || [ $(wc -l < "$DONE_FILE") -eq 0 ]; then
            echo "Nothing to undo."
            exit 0
        fi

        # Get the first line from DONE_FILE
        UNDONE_TASK=$(head -n 1 "$DONE_FILE")

        # Remove everything after the last space before the "|" (date part)
        UNDONE_TASK=$(echo "$UNDONE_TASK" | sed 's/.|.*//')

        # Append the undone task to the end of DOING_FILE
        echo "$UNDONE_TASK" >> "$DOING_FILE"
        # Recalculate TOTAL_LINES
        TOTAL_LINES=$(wc -l < "$DOING_FILE")
        # Remove the first line from DONE_FILE
        sed -i '1d' "$DONE_FILE"
        # Update the LINE_NUMBER to reflect the new last line in DOING_FILE
        LINE_NUMBER=$((TOTAL_LINES))
        sed -i "1s/^.*$/$LINE_NUMBER/" "$DOING_FILE"
        ;;
    *)
        echo "Invalid action. Use done, undo, next-do, prev-do, toggle-show, next-file, prev-file"
        exit 1
        ;;
esac

