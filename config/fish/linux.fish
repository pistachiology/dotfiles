

# Personal Linux

function sound-volume
    pactl set-sink-volume @DEFAULT_SINK@ $1
end
