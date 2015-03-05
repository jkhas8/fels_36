module WordsHelper
  def category_selected category
    unless category.nil?
      [@category.name, @category.id]
    end
  end

  def category_list
    [["All", ""]] + Category.all.collect do |category|
      [category.name, category.id]
    end
  end
end
