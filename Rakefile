require 'rake/clean'

CLEAN.include('*.h264').include('*.aac')
CLOBBER.include('*.mp4')

task :default => [:convert]

EXT  = ENV['ext'] || 'rmvb'
SRC  = FileList["*.#{EXT}"]
MP4  = SRC.ext('mp4')
NOSUB  = ENV['nosub']
SUBEXT = ENV['subext']

task :convert => MP4

X264_OPTS = {
  :fast   => { :mencoder => "subq=4:level_idc=12:nocabac:bframes=0",
               :ffmpeg   => "-flags +loop -me_method dia -g 250 -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -bf 16 -b_strategy 1 -i_qfactor 0.71 -cmp +chroma -subq 1 -me_range 16 -coder 1 -sc_threshold 40 -flags2 -bpyramid-wpred-mixed_refs-dct8x8+fastpskip -keyint_min 25 -refs 1 -trellis 0 -directpred 1 -partitions -parti8x8-parti4x4-partp8x8-partp4x4-partb8x8" },
  :normal => { :mencoder => "subq=5:frameref=2:level_idc=12:nocabac:bframes=0",
               :ffmpeg   => "-flags +loop+mv4 -cmp 256 -partitions +parti4x4+parti8x8+partp4x4+partp8x8+partb8x8 -me_method hex -subq 7 -trellis 1 -refs 5 -bf 0 -flags2 +mixed_refs -coder 0 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -qmin 10 -qmax 51 -qdiff 4" },
  :high   => { :mencoder => "subq=6:frameref=5:me=3:level_idc=12:nocabac:bframes=0",
               :ffmpeg   => "-flags +loop -me_method umh -g 250 -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -bf 16 -b_strategy 1 -i_qfactor 0.71 -cmp +chroma -subq 8 -me_range 16 -coder 1 -sc_threshold 40 -flags2 +bpyramid+wpred+mixed_refs+dct8x8+fastpskip -keyint_min 25 -refs 4 -trellis 1 -directpred 3 -partitions +parti8x8+parti4x4+partp8x8+partb8x8" },
}

X264_OPT_STR = ENV['x264'] || :normal
X264_FFMPEG_OPT = "#{X264_OPTS[X264_OPT_STR.to_sym][:ffmpeg]}"
X264_MENCODER_OPT = "-x264encopts #{X264_OPTS[X264_OPT_STR.to_sym][:mencoder]}"

rule '.mp4' => ".#{EXT}" do |t|
  if !NOSUB && SUBEXT != "none"
    r = Regexp.new("#{EXT}$", "i")
    sub = t.source.gsub(r, "#{SUBEXT}")
    subopt = %{-font "Kai" -subcp utf-8 -sub "#{sub}"}
  else
    if !NOSUB
      subopt = %{-font "Kai" -subcp utf-8}
    else
      subopt = ""
    end
  end
  sh %{mencoder "#{t.source}" #{subopt} -ovc x264 #{X264_MENCODER_OPT} -oac faac -faacopts mpeg=4:object=2 -o temp.avi #{ENV['extopts']} -vf harddup}
  sh %{ffmpeg -i temp.avi -vcodec copy -acodec copy -absf aac_adtstoasc -y "#{t.name}"}
#  else
#    sh %{ffmpeg -y -i "#{t.source}" -acodec libfaac -vcodec libx264 #{X264_FFMPEG_OPT} #{ENV['extopts']} "#{t.name}"}
#  end
end

# 2pass:
# - x264=fast extopts="-pass 1"
# - x264=high extopts="-pass 2"
