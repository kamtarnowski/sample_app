def pluralize(number, word)
  if number > 1
    word = "#{word}s"
  end
  "#{number} #{word}"
end

pluralize(5, "kamil")