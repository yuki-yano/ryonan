require 'fileutils'
require 'logger'

module Ryonan
  class Filer
    attr_accessor :root

    def initialize(root)
      self.root = root
    end

    def files
      Dir.glob("#{root}/**/*")
    end

    def dirs
      files.select { |file_path| FileTest.directory?(file_path) }
    end

    def templatable_dirs
      dirs.select { |dir| Dir::entries(dir).any? { |file| file == '.template' } }
    end

    def erbs
      files.select { |file_path| file_path.match(/\.erb$/) }
    end

    def recursive_rename_files(from, to)
      from_value = "__#{from}__"
      while files.any? { |dir| dir.match(/#{from_value}/) }
        src  = files.select { |dir| dir.match(/#{from_value}/) }.first
        dest = src.gsub(/#{from_value}/, to)
        Filer.mv(src, dest)
      end
    end

    def render_erbs(variable_hash)
      erbs.each do |erb|
        Filer.render_erb(erb, variable_hash)
      end
    end

    class << self
      attr_writer :logger

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def cp_r(src, dest)
        logger.info("cp -r #{src} #{dest}")
        FileUtils.cp_r(src, dest)
      end

      def mv(src, dest)
        logger.info("mv #{src} #{dest}")
        FileUtils.mv(src, dest)
      end

      def rm(file)
        logger.info("rm #{file}")
        FileUtils.rm(file)
      end
      
      def render_erb(erb, hash)
        result = Renderer.new(hash).render(open(erb).read)
        Filer.logger.info("render_erb #{erb} to #{erb.gsub(/\.erb$/, '')}")
        open(erb.gsub(/\.erb$/, ''), 'w') { |file| file.puts(result) }
        Filer.rm(erb)
      end
    end
  end
end
