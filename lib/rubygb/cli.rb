module Rubygb
  class CLI < Thor
    def build filename
      Rubygb.build filename
    end
  end
end
