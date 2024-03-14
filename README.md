# Garmin Dog

## Ffmpeg from video to pics
fps=2 - extract frame each 500ms
scale: `300` - width, `-1` - height proportional to width
```sh
ffmpeg -i input_video.mp4 -vf "fps=2,scale=300:-1" frame_%04d.jpg
```

## Simulator
`task simulator`

## Dev
`task dev`