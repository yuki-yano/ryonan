require 'readline'

module Ryonan
  module Interactive
    class << self
      def print_template_list(filer)
        puts 'Templete List'
        filer.templatable_dirs.map.with_index do |dir, index|
          puts "    [#{index}] : '#{dir}'"
        end
        puts ''
      end

      def select_template(filer)
        select = Readline.readline('Select Templete[*] -> ')
        if select.match(/\d+/) && !filer.templatable_dirs[select.to_i].nil?
          filer.templatable_dirs[select.to_i]
        else
          puts 'The specified template does not exist'
          exit 1
        end
      end

      def set_template_name
        name = Readline.readline('Input the destination directory name -> ')
        if name == Config.template_dir_name
          puts "#{Config.template_dir_name} will overlap with the template directory name"
          exit 1
        else
          name
        end
      end

      def set_configs(template_root)
        puts 'Set the value to the variable in the template'
        variables = File.open("#{template_root}/#{Config.template_dir_name}/#{Config.config_file_name}").readlines.map(&:chomp)
        variables.reduce({}) do |acc, variable_name|
          variable_value = Readline.readline("    #{variable_name} -> ")
          acc[variable_name.to_sym] = variable_value
          acc
        end
      end
    end
  end
end