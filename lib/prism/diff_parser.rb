module Prism
  class DiffParser
    def self.affected_files(diff)
      files = []
      diff.split("\n").each do |line|
        files << _extract_filename(line) if _is_file?(line)
      end
      files
    end

    def self._is_file?(line)
      line.start_with?("+++ ") || line.start_with?("--- ")
    end

    def self._extract_filename(line)
      /(a|b)\/(\S+)$/.match(line).captures[1]
    end
  end
end
