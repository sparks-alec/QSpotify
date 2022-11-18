# QSpotify

*Play Spotify tracks and playlists, as well as fades and loops, all from within QLab*

Using QSpotify is fairly simple. Start by [downloading this repository](https://github.com/sparks-alec/QSpotify/archive/refs/heads/main.zip).

1- Open `QSpotify Demo V5/QSpotify Demo V5.qlab5` in the downloaded folder

2- Open QLab's Cue List pane by clicking the list icon in the bottom right corner of the main QLab window.

3- Navigate to the `Spotify Config` Cue List

4- Change the Name of the `SPOTPATH` cue to reflect the path to the `QSpotify_1.4.scpt` file on your computer. This .scpt file was included in the downloaded repository. EX: `/Users/yourname/Downloads/QSpotify-main/QSpotify_1.4.scpt`

## Getting Spotify URIs
This used to be easier. Now you must hold <kbd>⌥ Option</kbd> after clicking the <kbd>...</kbd> share button to turn the `Copy Song Link` menu into a `Copy Song URI` menu.


## Troubleshooting

If running a QSpotify cue returns an error such as `ERROR: A real number can't go after this identifier` or `ERROR: A "/" can't go here.`, there is likely a problem with the path to the QSpotify scpt file.

A paid version of QLab is mostly necessary for QSpotify, becuase saved Script cues cannot be loaded with the free version.

If multiple QLab workspaces are being used, the Script Cue script will need to be adjusted. Replace the script with `run script (q name of cue "SPOTPATH" in workspace "QSpotify Demo.qlab4" & "")`, replacing `QSpotify Demo` with the name of your QLab file.


