class Picture < ApplicationRecord
  has_many :chatroom_pictures
  has_many :chatrooms, through: :chatroom_pictures

  has_many :memes
  has_many :users, through: :memes

  validates :avatar,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 4.megabytes }
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '600x600>',
    xl: '1200x1200',
  },
  # convert_options: {
  #   thumb: "mogrify -filter Triangle -define filter:support=2 -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip INPUT_PATH",
  #   square: "mogrify -filter Triangle -define filter:support=2 -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip INPUT_PATH",
  #   medium: "mogrify -filter Triangle -define filter:support=2 -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip INPUT_PATH",
  #   large: "mogrify -filter Triangle -define filter:support=2 -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB -strip INPUT_PATH"
  # },
  default_url: "/images/:style/missing.png"

  # Validate the attached image is image/jpg, image/png, etc
end