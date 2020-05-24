#!/usr/bin/env bash
# find plots of simulation data

# Various options for the file browser script:
ROFI_FB_GENERIC_FO="sxiv" # command used for opening the selection
ROFI_FB_PREV_LOC_FILE=~/.local/share/rofi/rofi_fb_prevloc
# Comment the next variable to always start in the last visited directory,
# otherwise rofi_fb will start in the specified directory:
ROFI_FB_START_DIR="/home/michar/Documents/Studium/Masterarbeit/Simulation/Scan+Plot-Scripts_git/Data" # starting directory
# Uncomment the following line to disable history:


# Beginning of the script:
# Create the directory for the files of the script
if [ ! -d $(dirname "${ROFI_FB_PREV_LOC_FILE}") ]
then
    mkdir -p "$(dirname "${ROFI_FB_PREV_LOC_FILE}")"
fi
if [ ! -d $(dirname "${ROFI_FB_HISTORY_FILE}") ]
then
    mkdir -p "$(dirname "${ROFI_FB_HISTORY_FILE}")"
fi

# Initialize $ROFI_FB_CUR_DIR
if [ -d "${ROFI_FB_START_DIR}" ]; then
    ROFI_FB_CUR_DIR="${ROFI_FB_START_DIR}"
else
    ROFI_FB_CUR_DIR="$PWD"
fi

# Read last location, otherwise we default to $ROFI_FB_START_DIR or $PWD.
if [ -f "${ROFI_FB_PREV_LOC_FILE}" ]
then
    ROFI_FB_CUR_DIR=$(cat "${ROFI_FB_PREV_LOC_FILE}") 
fi 

# If parameter scan is selected, jump directly to plots
if [[ -n "$@" && "$@" != "" ]]; then
    if [ "${ROFI_FB_CUR_DIR}" == "${ROFI_FB_START_DIR}" ]; then
        ROFI_FB_CUR_DIR="${ROFI_FB_CUR_DIR}/$@/Plots"
    else
        ROFI_FB_CUR_DIR="${ROFI_FB_CUR_DIR}/$@"
    fi
fi

# If argument is no directory.
if [ ! -d "${ROFI_FB_CUR_DIR}" ]
then
    if [[ "${ROFI_FB_CUR_DIR}" =~ .*\.(png|gif|jpg) ]]; then
        # Open the selected entry with $ROFI_FB_GENERIC_FO
        coproc ( "${ROFI_FB_GENERIC_FO}" "${ROFI_FB_CUR_DIR}"  > /dev/null  2>&1 )
        # exec "${ROFI_FB_GENERIC_FO}" "${ROFI_FB_CUR_DIR}"
        if [ -d "${ROFI_FB_START_DIR}" ]; then
            echo "${ROFI_FB_START_DIR}" > "${ROFI_FB_PREV_LOC_FILE}"
        fi
        exit;
    fi
    exit;
fi

# Process current dir.
if [ -n "${ROFI_FB_CUR_DIR}" ]; then
    ROFI_FB_CUR_DIR=$(readlink -e "${ROFI_FB_CUR_DIR}")
    echo "${ROFI_FB_CUR_DIR}" > "${ROFI_FB_PREV_LOC_FILE}"
    pushd "${ROFI_FB_CUR_DIR}" >/dev/null
fi

# Output to rofi
if [[ "${ROFI_FB_NO_HISTORY}" -ne 1 ]]; then
    tac "${ROFI_FB_HISTORY_FILE}" | grep "${ROFI_FB_CUR_DIR}"
fi
echo ".."
ls
# vim:sw=4:ts=4:et: