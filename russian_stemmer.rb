# Stems a Russian text file, and optionally lists words by inverse generalized frequency,
# or let's you look up all the conjugations for a specific stem

class Object
  def add_safe(var,val)
    if val.class == Fixnum
      if self[var].nil?
        self[var] = val
      else
        self[var] = self[var] + val
      end
    else
      if self[var].nil?
        self[var] = [val]
      else
        self[var] = self[var] + [val]
      end
    end
  end
end

class Hash
  def add_safe(var,val)
    super
  end
  alias :add :add_safe  # we've already used this in the code
end

require "unicode_utils/downcase"

class Freq
  def initialize(default = 9999)
    @default = default

    freqfile = "lemma.num"
    @freq = {}
    c = 0
    File.open(freqfile).each_line do |l|
      c += 1
      _,_,w,_ = l.split
      @freq[w] = c
    end
  end

  def get(f)
    @freq[f] or @default
  end
end

class Russian_Stemmer
  attr_reader :stems, :raw_words_size, :wordvars

  def initialize(textfile)
    textstem = `cat '#{textfile}' | hunspell -d ru_RU,ru_RU_google -s`
    stems = {}
    wordvars = {}
    raw_words_size = 0
    textstem.each_line do |line|
      line.strip!
      next if line == ""
      next unless line.index(" ")
      raw_words_size += 1
      w, stem = line.split(" ")
      stem.strip!
      w.strip!
      stems.add(stem, 1)
      wordvars.add(stem, w)
    end

    @freq = Freq.new
    @wordvars = wordvars
    @stems = stems
    @raw_words_size = raw_words_size
  end

  def stems_by_frequency(min_occur = 0)
    stems_red = stems.reject {|k, v| v < min_occur}
    stems_red.sort_by {|k, v| -@freq.get(k)}
  end


end
