
# Usage: rake publish _drafts/publish-name.rm
desc "publish file in _drafts to _post"
task :publish do
	require "date"

	if ARGV.length == 2
		source = ARGV.last
		text = File.read(source)
		text.gsub!(/^published.*$/, "published: true")
		today = Date.today
		post_name = source.split("/").last
		dest = "_posts/#{today.year}-#{today.month}-#{today.day}-#{post_name}"
		File.open(dest, 'w') {|f| f.write(text) }
		STDOUT.puts "publish file #{post_name}"
	else
		puts "Wrong number of args"
	end

	ARGV.each_with_index do |arg, i|
		if (i != 0)
			task arg.to_sym do
			end
		end
	end
end

