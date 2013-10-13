module TracksHelper
  def lyrics_for(track)
    lyrics = track.lyrics.split(/\n/).map {|line| "&#9835; #{h(line)}"}.join("\n")
    "<pre>#{lyrics}</pre>".html_safe
  end
end
