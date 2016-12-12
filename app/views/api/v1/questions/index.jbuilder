json.array! @questions do |question|
  json.(question,:id,:description)
end
