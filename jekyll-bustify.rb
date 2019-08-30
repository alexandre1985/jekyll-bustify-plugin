require 'digest/md5'

module Jekyll
	module Bustify
		def rename_string_file_extension(source, extension)
			dirname  = File.dirname(source)
			basename = File.basename(source, ".*")
			extname  = File.extname(source)
			if extname == ""
				if basename[0,1]=="."
					target = dirname + "/." + extension
				else
					target = source + "." + extension
				end
			else
				target = dirname + "/" + basename + "." + extension
			end
			target
		end

		def bustify(input, length=5)
			file_path = File.join(File.dirname(__FILE__), '..', '_site', input).strip
			# the right way would be to use this line below instead, but my lack of knowleadge make me do a hack.
			#file_path = File.join(File.dirname(__FILE__), '..', input).strip
			# The hack, of reading the asset file in the _site directory, leads to having to run `jekyll build` to times to achive the desired hash result when an asset is modified :// (not always needed, only when a modification is made on an asset dependency of other asset, such as sass dependency file that is called as an import on other sass file)


			asset_file_extension = File.extname(file_path)

			file_path_of__site = file_path
			output_path = input

			# if is a SASS CSS file, transform to css (because of the hack of using the _site directory :/ )
			if [".scss", ".sass"].include? asset_file_extension
				file_path_of__site = rename_string_file_extension(file_path, "css")
				output_path = rename_string_file_extension(input, "css")
			end


			file_content = File.read(file_path_of__site)

			# It would be here where to make a rendering of the jekyll asset (I called it Jekyll processing) but I can't make this implementation work.... :/ I have tried

			# site = @context.registers[:site]

     		# content_parsed = site.find_converter_instance(Jekyll::Converters::Identity).convert(file_content.to_s)
     		
     		# content_parsed1 = Jekyll::Renderer.new(@site, file_path, @payload)
     		# content_parsed = content_parsed1.render_document
			# file_hash = Digest::MD5.hexdigest content_parsed
			
			file_hash = Digest::MD5.hexdigest file_content

			output_hash = file_hash[-length..-1]


			"#{output_path}?cb=#{output_hash}"
		end
	end
end

Liquid::Template.register_filter(Jekyll::Bustify)
