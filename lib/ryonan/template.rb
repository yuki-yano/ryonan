module Ryonan
  class Template
    def self.create(template_root, name, variable_hash)
      Filer.cp_r("#{template_root}/#{Config.template_dir_name}", "#{template_root}/#{name}")
      Filer.rm("#{template_root}/#{name}/#{Config.config_file_name}")
      filer = Filer.new("#{template_root}/#{name}")
      filer.recursive_rename_files(variable_hash)
      filer.render_erbs(variable_hash)
    end
  end
end
