module Ryonan
  class Template
    def self.create(template_root, name, variable_hash)
      if name.empty?
        Filer.cp_r(Dir.glob("#{template_root}/#{Config.template_dir_name}/*"), "#{template_root}/")
      else
        Filer.cp_r("#{template_root}/#{Config.template_dir_name}", "#{template_root}/#{name}")
        Filer.rm("#{template_root}/#{name}/#{Config.config_file_name}")
      end
      filer = Filer.new("#{template_root}/#{name}")

      variable_hash.each do |key, value|
        filer.recursive_rename_files(key, value)
      end
      
      filer.render_erbs(variable_hash)
    end
  end
end
