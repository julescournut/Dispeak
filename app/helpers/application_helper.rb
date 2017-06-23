module ApplicationHelper
  def list_image_assets(dir_name)
  path = File.expand_path("../../../app/assets/images/#{dir_name}", __FILE__)
  full_paths = Dir.glob "#{path}/**.*"
  assets_map = {}
  full_paths.each do |p|
    original_name = File.basename p
    asset_path    = asset_path p[p.index("#{dir_name}")..-1]
    assets_map[original_name] = asset_path
  end
  assets_map.to_json
end
end
