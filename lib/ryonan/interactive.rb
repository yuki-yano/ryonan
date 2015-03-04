require 'readline'

module Ryonan
  module Interactive
    class << self
      def print_template_list(filer)
        puts 'Template List'
        filer.templatable_dirs.map.with_index do |dir, index|
          puts "    [#{index}] : '#{dir}'"
        end
        puts ''
      end

      def select_template(filer)
        select = Readline.readline('Select Template[*] -> ')
        if select.match(/\d+/) && !filer.templatable_dirs[select.to_i].nil?
          filer.templatable_dirs[select.to_i]
        else
          puts 'The specified template does not exist'
          exit 1
        end
      end

      def input_template_name
        name = Readline.readline('Input the destination directory name -> ')
        if name == Config.template_dir_name
          puts "#{Config.template_dir_name} will overlap with the template directory name"
          exit 1
        else
          name
        end
      end

      def input_configs(template_root)
        puts 'Set the value to the variable in the template'
        variables = File.open("#{template_root}/#{Config.template_dir_name}/#{Config.config_file_name}").readlines.map(&:chomp)
        variables.reduce({}) do |acc, line|
          if line.match(/.+=/)
            (variable_name, default) = line.split('=')
            input = Readline.readline("    #{variable_name} (Default:#{default}) -> ")
            variable_value = input.empty? ? default : input
          else
            variable_name = line
            variable_value = Readline.readline("    #{variable_name} -> ")
          end
          acc[variable_name.to_sym] = variable_value
          acc
        end
      end
    end
  end
end