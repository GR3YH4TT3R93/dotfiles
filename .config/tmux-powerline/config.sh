# Default configuration file for tmux-powerline.
# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0 tabstop=4 filetype=sh
# }

# General {
 # Show which segment fails and its exit code.
 export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
 # Use patched font symbols.
 export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

 # The theme to use.
 export TMUX_POWERLINE_THEME="my-theme"
 # Overlay directory to look for themes. There you can put your own themes outside the repo. Fallback will still be the "themes" directory in the repo.
 export TMUX_POWERLINE_DIR_USER_THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/themes"
 # Overlay directory to look for segments. There you can put your own segments outside the repo. Fallback will still be the "segments" directory in the repo.
 export TMUX_POWERLINE_DIR_USER_SEGMENTS="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/segments"

 # The initial visibility of the status bar. Can be {"on", "off", "2"}. 2 will create two status lines: one for the window list and one with status bar segments.
 export TMUX_POWERLINE_STATUS_VISIBILITY="on"
 # In case of visibility = 2, where to display window status and where left/right status bars.
 # 0: window status top, left/right status bottom; 1: window status bottom, left/right status top
 export TMUX_POWERLINE_WINDOW_STATUS_LINE=0
 # The status bar refresh interval in seconds.
 # Note that events that force-refresh the status bar (such as window renaming) will ignore this.
 export TMUX_POWERLINE_STATUS_INTERVAL="1"
 # The location of the window list. Can be {"absolute-centre, centre, left, right"}.
 # Note that "absolute-centre" is only supported on `tmux -V` >= 3.2.
 export TMUX_POWERLINE_STATUS_JUSTIFICATION="left"

 # The maximum length of the left status bar.
 export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
 # The maximum length of the right status bar.
 export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="90"

 # The separator to use between windows on the status bar.
 export TMUX_POWERLINE_WINDOW_STATUS_SEPARATOR=""

 # Uncomment these if you want to enable tmux bindings for muting (hiding) one of the status bars.
 # E.g. this example binding would mute the left status bar when pressing <prefix> followed by Ctrl-[
 #export TMUX_POWERLINE_MUTE_LEFT_KEYBINDING="C-["
 #export TMUX_POWERLINE_MUTE_RIGHT_KEYBINDING="C-]"
# }

# air.sh {
 # The data provider to use. Currently only "openweather" is supported.
 export TMUX_POWERLINE_SEG_AIR_DATA_PROVIDER="openweather"
 # How often to update the weather in seconds.
 export TMUX_POWERLINE_SEG_AIR_UPDATE_PERIOD="600"
 # Location of the JSON parser, jq
 export TMUX_POWERLINE_SEG_AIR_JSON="jq"
 # Your location
 # Latitude and Longitude:
 TMUX_POWERLINE_SEG_AIR_LAT=""
 TMUX_POWERLINE_SEG_AIR_LON=""
 # Your Open Weather API Key:
 TMUX_POWERLINE_SEG_AIR_OPEN_WEATHER_API_KEY=""
# }

# battery.sh {
 # How to display battery remaining. Can be {percentage, cute}.
 # export TMUX_POWERLINE_SEG_BATTERY_TYPE="percentage"
 # How may hearts to show if cute indicators are used.
 # export TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS="5"
# }

# date.sh {
 # date(1) format for the date. If you don't, for some reason, like ISO 8601 format you might want to have "%D" or "%m/%d/%Y".
 export TMUX_POWERLINE_SEG_DATE_FORMAT="%m/%d"
# }

# date_week.sh {
 # Symbol for calendar week.
 # export TMUX_POWERLINE_SEG_DATE_WEEK_SYMBOL="󰨳"
 # export TMUX_POWERLINE_SEG_DATE_WEEK_SYMBOL_COLOUR="255"
# }

# disk_usage.sh {
 # Filesystem to retrieve disk space information. Any from the filesystems available (run "df | awk '{print }'" to check them).
 export TMUX_POWERLINE_SEG_DISK_USAGE_FILESYSTEM="${HOME}"
# }

# earthquake.sh {
 # The data provider to use. Currently only "goo" is supported.
 export TMUX_POWERLINE_SEG_EARTHQUAKE_DATA_PROVIDER="goo"
 # How often to update the earthquake data in seconds.
 # Note: This is not an early warning detector, use this
 # to be informed about recent earthquake magnitudes in your
 # area. If this is too often, goo may decide to ban you form
 # their server
 export TMUX_POWERLINE_SEG_EARTHQUAKE_UPDATE_PERIOD="600"
 # Only display information when earthquakes are within this many minutes
 export TMUX_POWERLINE_SEG_EARTHQUAKE_ALERT_TIME_WINDOW="60"
 # Display time with this format
 export TMUX_POWERLINE_SEG_EARTHQUAKE_TIME_FORMAT='(%H:%M)'
 # Display only if magnitude is greater or equal to this number
 export TMUX_POWERLINE_SEG_EARTHQUAKE_MIN_MAGNITUDE="3"
# }

# gcalcli.sh {
 # gcalcli uses 24hr time format by default - if you want to see 12hr time format, set TMUX_POWERLINE_SEG_GCALCLI_MILITARY_TIME_DEFAULT to 0
 export TMUX_POWERLINE_SEG_GCALCLI_24HR_TIME_FORMAT="0"
# }

# hostname.sh {
 # Use short or long format for the hostname. Can be {"short, long"}.
 export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="short"
# }

# ifstat.sh {
 # Symbol for Download.
 # export TMUX_POWERLINE_SEG_IFSTAT_DOWN_SYMBOL="⇊"
 # Symbol for Upload.
 # export TMUX_POWERLINE_SEG_IFSTAT_UP_SYMBOL="⇈"
 # Symbol for Ethernet.
 # export TMUX_POWERLINE_SEG_IFSTAT_ETHERNET_SYMBOL="󰈀"
 # Symbol for WLAN.
 # export TMUX_POWERLINE_SEG_IFSTAT_WLAN_SYMBOL="󱚻"
 # Symbol for WWAN.
 # export TMUX_POWERLINE_SEG_IFSTAT_WWAN_SYMBOL=""
 # Separator for Interfaces.
 # export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_SEPARATOR=" | "
 # Space separated list of interface names to be excluded. substring match, regexp can be used.
 # Examples:
 # export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="tun" # will exclude 'tun0', 'utun0', 'itun', 'tun08127387'
 # export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="tun0 tuntun" # will exclude 'tun0', 'utun0', 'tuntun'
 # export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="^tun0$ ^tun1$" # excludes exactly 'tun0' and 'tun1'
 # Default:
 # export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="^u?tun[0-9]+$"
# }

# kubernetes_context.sh {
 # Kubernetes config context display mode {"name_namespace", "name", "namespace"}.
 # export TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_DISPLAY_MODE="name_namespace"
 # Kubernetes config context symbol.
 # export TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_SYMBOL="󱃾"
 # Kubernetes config context symbol colour.
 # export TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_SYMBOL_COLOUR="255"
 # Separator for display mode "name_namespace"
 # TMUX_POWERLINE_SEG_KUBERNETES_CONTEXT_SEPARATOR="󰿟"
# }

# lan_ip.sh {
 # Symbol for LAN IP.
 export TMUX_POWERLINE_SEG_LAN_IP_SYMBOL="ⓛ "
 # Symbol colour for LAN IP
 export TMUX_POWERLINE_SEG_LAN_IP_SYMBOL_COLOUR="255"
# }

# macos_notification_count.sh {

# }

# mailcount.sh {
 # Mailbox type to use. Can be any of {apple_mail, gmail, maildir, mbox, mailcheck}
 export TMUX_POWERLINE_SEG_MAILCOUNT_MAILBOX_TYPE=""

 ## Gmail
 # Enter your Gmail username here WITH OUT @gmail.com.( OR @domain)
 export TMUX_POWERLINE_SEG_MAILCOUNT_GMAIL_USERNAME=""
 # Google password. Recomenned to use application specific password (https://accounts.google.com/b/0/IssuedAuthSubTokens) Leave this empty to get password from OS X keychain.
 # For OSX users : MAKE SURE that you add a key to the keychain in the format as follows
 # Keychain Item name : http://<value-you-fill-in-server-variable-below>
 # Account name : <username-below>@<server-below>
 # Password : Your password ( Once again, try to use 2 step-verification and application-specific password)
 # See http://support.google.com/accounts/bin/answer.py?hl=en&answer=185833 for more info.
 export TMUX_POWERLINE_SEG_MAILCOUNT_GMAIL_PASSWORD=""
 # Domain name that will complete your email. For normal GMail users it probably is "gmail.com but can be "foo.tld" for Google Apps users.
 export TMUX_POWERLINE_SEG_MAILCOUNT_GMAIL_SERVER="gmail.com"
 # How often in minutes to check for new mails.
 export TMUX_POWERLINE_SEG_MAILCOUNT_GMAIL_INTERVAL="5"

 ## Maildir
 # Path to the maildir to check.
 export TMUX_POWERLINE_SEG_MAILCOUNT_MAILDIR_INBOX="/data/data/com.termux/files/home/.mail/inbox/new"

 ## mbox
 # Path to the mbox to check.
 export TMUX_POWERLINE_SEG_MAILCOUNT_MBOX_INBOX=""

 ## mailcheck
 # Optional path to mailcheckrc
 export TMUX_POWERLINE_SEG_MAILCOUNT_MAILCHECKRC="/data/data/com.termux/files/home/.mailcheckrc"
# }

# mode_indicator.sh {
 # Whether the normal & prefix mode section should be enabled. Should be {"true, "false"}.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_NORMAL_AND_PREFIX_MODE_ENABLED="true"
 # Normal mode text & color overrides. Defaults to "normal" & the segment foreground color set in the theme used.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_NORMAL_MODE_TEXT="normal"
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_NORMAL_MODE_TEXT_COLOR=""
 # Prefix mode text & color overrides. Defaults to "prefix" & the segment foreground color set in the theme used.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_PREFIX_MODE_TEXT="prefix"
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_PREFIX_MODE_TEXT_COLOR=""
 # Whether the mouse mode section should be enabled. Should be {"true, "false"}.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_MOUSE_MODE_ENABLED="true"
 # Mouse mode text & color overrides. Defaults to "mouse" & the segment foreground color set in the theme used.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_MOUSE_MODE_TEXT="mouse"
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_MOUSE_MODE_TEXT_COLOR=""
 # Whether the copy mode section should be enabled. Should be {"true, "false"}.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_COPY_MODE_ENABLED="true"
 # Copy mode text & color overrides. Defaults to "copy" & the segment foreground color set in the theme used.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_COPY_MODE_TEXT="copy"
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_COPY_MODE_TEXT_COLOR=""
 # Suspend mode text & color overrides. Defaults to "SUSPEND" & the segment foreground color set in the theme used.
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_SUSPEND_MODE_TEXT="SUSPEND"
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_SUSPEND_MODE_TEXT_COLOR=""
 # Separator text override. Defaults to " • ".
 export TMUX_POWERLINE_SEG_MODE_INDICATOR_SEPARATOR_TEXT=" • "
# }

# now_playing.sh {
 # Music player to use. Can be any of {audacious, banshee, cmus, apple_music, itunes, lastfm, plexamp, mocp, mpd, mpd_simple, pithos, playerctl, rdio, rhythmbox, spotify, spotify_wine, file}.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER="spotify"
 # File to be read in case the song is being read from a file
 export TMUX_POWERLINE_SEG_NOW_PLAYING_FILE_NAME=""
 # Maximum output length.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_MAX_LEN="40"
 # How to handle too long strings. Can be {trim, roll}.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_TRIM_METHOD="trim"
 # Characters per second to roll if rolling trim method is used.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_SPEED="2"
 # Mode of roll text {"space", "repeat"}. space: fill up with empty space; repeat: repeat text from beginning
 # export TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_MODE="repeat"
 # Separator for "repeat" roll mode
 # export TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_SEPARATOR="   "
 # If set to 'true', 'yes', 'on' or '1', played tracks will be logged to a file.
 # export TMUX_POWERLINE_SEG_NOW_PLAYING_TRACK_LOG_ENABLE="false"
 # If enabled, log played tracks to the following file:
 # export TMUX_POWERLINE_SEG_NOW_PLAYING_TRACK_LOG_FILEPATH="/data/data/com.termux/files/home/.now_playing.log"
 # Maximum number of logged song entries. Set to "unlimited" for unlimited entries.
 # export TMUX_POWERLINE_SEG_NOW_PLAYING_TRACK_LOG_MAX_ENTRIES="100"

 # Hostname for MPD server in the format "[password@]host"
 export TMUX_POWERLINE_SEG_NOW_PLAYING_MPD_HOST="localhost"
 # Port the MPD server is running on.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_MPD_PORT="6600"
 # Song display format for mpd_simple. See mpc(1) for delimiters.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_MPD_SIMPLE_FORMAT="%artist% - %title%"
 # Song display format for playerctl. see "Format Strings" in playerctl(1).
 export TMUX_POWERLINE_SEG_NOW_PLAYING_PLAYERCTL_FORMAT="{{ artist }} - {{ title }}"
 # Song display format for rhythmbox. see "FORMATS" in rhythmbox-client(1).
 export TMUX_POWERLINE_SEG_NOW_PLAYING_RHYTHMBOX_FORMAT="%aa - %tt"

 # Last.fm
 # Set up steps for Last.fm
 # 1. Make sure jq(1) is installed on the system.
 # 2. Create a new API application at https://www.last.fm/api/account/create (name it tmux-powerline) and copy the API key and insert it below in the setting TMUX_POWERLINE_SEG_NOW_PLAYING_LASTFM_API_KEY
 # 3. Make sure the API can access your recently played song by going to you user privacy settings https://www.last.fm/settings/privacy and make sure "Hide recent listening information" is UNCHECKED.
 # Username for Last.fm if that music player is used.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_LASTFM_USERNAME=""
 # API Key for the API.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_LASTFM_API_KEY=""
 # How often in seconds to update the data from last.fm.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_LASTFM_UPDATE_PERIOD="30"
 # Fancy char to display before now playing track
 export TMUX_POWERLINE_SEG_NOW_PLAYING_NOTE_CHAR="♫"

 # Plexamp
 # Set up steps for Plexamp
 # 1. Make sure jq(1) is installed on the system.
 # 2. Make sure you have an instance of Tautulli that is accessible by the computer running tmux-powerline.
 # Username for Plexamp if that music player is used.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_PLEXAMP_USERNAME=""
 # Hostname for Tautulli server in the format "[password@]host"
 export TMUX_POWERLINE_SEG_NOW_PLAYING_PLEXAMP_TAUTULLI_HOST=""
 # API Key for Tautulli.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_PLEXAMP_TAUTULLI_API_KEY=""
 # How often in seconds to update the data from Plexamp.
 export TMUX_POWERLINE_SEG_NOW_PLAYING_PLEXAMP_UPDATE_PERIOD="30"
# }

# pwd.sh {
 # Maximum length of output.
 export TMUX_POWERLINE_SEG_PWD_MAX_LEN="40"
# }

# time.sh {
 # date(1) format for the time. Americans might want to have "%I:%M %p".
 export TMUX_POWERLINE_SEG_TIME_FORMAT="#[bold] %H:%M"
 # Change this to display a different timezone than the system default.
 # Use TZ Identifier like "America/Los_Angeles"
 # export TMUX_POWERLINE_SEG_TIME_TZ=""
# }

# tmux_mem_cpu_load.sh {
 # Arguments passed to tmux-mem-cpu-load.
 # See https://github.com/thewtex/tmux-mem-cpu-load for all available options.
 # export TMUX_POWERLINE_SEG_TMUX_MEM_CPU_LOAD_ARGS="-v"
# }

# tmux_session_info.sh {
 # Session info format to feed into the command: tmux display-message -p
 # For example, if FORMAT is '[ #S ]', the command is: tmux display-message -p '[ #S ]'
 # export TMUX_POWERLINE_SEG_TMUX_SESSION_INFO_FORMAT="#S:#I.#P"
 export TMUX_POWERLINE_SEG_TMUX_SESSION_INFO_FORMAT="#[bold]#S"
# }

# utc_time.sh {
 # date(1) format for the UTC time.
 export TMUX_POWERLINE_SEG_UTC_TIME_FORMAT="%H:%M %Z"
# }

# vcs_branch.sh {
 # Max length of the branch name.
 export TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN="10"
 # Symbol when branch length exceeds max length
 export TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNCATE_SYMBOL="󱪘"
 # Default branch symbol
 export TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL=""
 # Branch symbol for git repositories
 export TMUX_POWERLINE_SEG_VCS_BRANCH_GIT_SYMBOL="${TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL}"
 # Branch symbol for hg/mercurial repositories
 # export TMUX_POWERLINE_SEG_VCS_BRANCH_HG_SYMBOL="${TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL}"
 # Branch symbol for SVN repositories
 # export TMUX_POWERLINE_SEG_VCS_BRANCH_SVN_SYMBOL="${TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL}"
 # Branch symbol colour for git repositories
 export TMUX_POWERLINE_SEG_VCS_BRANCH_GIT_SYMBOL_COLOUR="#181a1f"
 # Branch symbol colour for hg/mercurial repositories
 export TMUX_POWERLINE_SEG_VCS_BRANCH_HG_SYMBOL_COLOUR="45"
 # Branch symbol colour for SVN repositories
 export TMUX_POWERLINE_SEG_VCS_BRANCH_SVN_SYMBOL_COLOUR="220"
# }

# vcs_compare.sh {
 # Symbol if local branch is behind.
 export TMUX_POWERLINE_SEG_VCS_COMPARE_AHEAD_SYMBOL="⇡"
 # Symbol colour if local branch is ahead. Defaults to "current segment foreground colour"
 # export TMUX_POWERLINE_SEG_VCS_COMPARE_AHEAD_SYMBOL_COLOUR=""
 # Symbol if local branch is ahead.
 export TMUX_POWERLINE_SEG_VCS_COMPARE_BEHIND_SYMBOL="↓"
 # Symbol colour if local branch is behind. Defaults to "current segment foreground colour"
 # export TMUX_POWERLINE_SEG_VCS_COMPARE_BEHIND_SYMBOL_COLOUR=""
# }

# vcs_modified.sh {
 # Symbol for count of modified vcs files.
 export TMUX_POWERLINE_SEG_VCS_MODIFIED_SYMBOL="󱪗"
# }

# vcs_others.sh {
 # Symbol for count of untracked vcs files.
 export TMUX_POWERLINE_SEG_VCS_OTHERS_SYMBOL="󱪘"
# }

# vcs_rootpath.sh {
 # Display mode for vcs_rootpath.
 # Example: (name: folder name only; path: full path, w/o expansion; user_path: full path, w/ tilde expansion)
 export TMUX_POWERLINE_SEG_VCS_ROOTPATH_MODE="name"
# }

# vcs_staged.sh {
 # Symbol for count of staged vcs files.
 export TMUX_POWERLINE_SEG_VCS_STAGED_SYMBOL="󱪝"
# }

# vpn.sh {
 # Mode for VPN segment {"both", "ip", "name"}. both: Show NIC/IP; ip: Show only IP; name: Show only NIC name
 # export TMUX_POWERLINE_SEG_VPN_DISPLAY_MODE="both"
 # Space separated list of tunnel interface names. First match is being used. substring match, regexp can be used.
 # Examples:
 # export TMUX_POWERLINE_SEG_VPN_NICS="tun" # will match 'tun0', 'utun0', 'itun', 'tun08127387'
 # export TMUX_POWERLINE_SEG_VPN_NICS="tun0 tuntun" # will match 'tun0', 'utun0', 'tuntun'
 # export TMUX_POWERLINE_SEG_VPN_NICS="^tun0$ ^tun1$" # exactly 'tun0' and 'tun1'
 # Default:
 # export TMUX_POWERLINE_SEG_VPN_NICS='^u?tun[0-9]+$'
 # Symbol to use for vpn tunnel.
 # export TMUX_POWERLINE_SEG_VPN_SYMBOL="󱠾 "
 # Colour for vpn tunnel symbol
 # export TMUX_POWERLINE_SEG_VPN_SYMBOL_COLOUR="255"
 # Symbol for separator
 # export TMUX_POWERLINE_SEG_VPN_DISPLAY_SEPARATOR="󰿟"
# }

# wan_ip.sh {
 # Symbol for WAN IP
 export TMUX_POWERLINE_SEG_WAN_IP_SYMBOL="ⓦ "
 # Symbol colour for WAN IP
 export TMUX_POWERLINE_SEG_WAN_IP_SYMBOL_COLOUR="255"
# }

# weather.sh {
 # The data provider to use. Currently only "yahoo" is supported.
 export TMUX_POWERLINE_SEG_WEATHER_DATA_PROVIDER="yrno"
 # What unit to use. Can be any of {c,f,k}.
 export TMUX_POWERLINE_SEG_WEATHER_UNIT="c"
 # How often to update the weather in seconds.
 export TMUX_POWERLINE_SEG_WEATHER_UPDATE_PERIOD="600"
 # Name of GNU grep binary if in PATH, or path to it.
 export TMUX_POWERLINE_SEG_WEATHER_GREP="grep"
 # Location of the JSON parser, jq
 export TMUX_POWERLINE_SEG_WEATHER_JSON="jq"
 # Your location
 # Latitude and Longtitude for use with yr.no
 TMUX_POWERLINE_SEG_WEATHER_LAT=""
 TMUX_POWERLINE_SEG_WEATHER_LON=""
# }

# xkb_layout.sh {
 # Keyboard icon
 export TMUX_POWERLINE_SEG_XKB_LAYOUT_ICON="⌨ "
# }
