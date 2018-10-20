class String
  def without_trailing_slash
    gsub(/\/+$/, "")
  end

  def resembles?(other : String)
    self == other
  end
end

module CircleciRedirection
  class WildcardString
    def initialize(@str : String)
      re_string = @str.split("*").map { |s| Regex.escape(s) }.join(".*")
      @re = Regex.new(re_string)
    end

    def +(other : String)
      WildcardString.new(@str + other)
    end

    def resembles?(other : String)
      !other.match(@re).nil?
    end
  end
end
