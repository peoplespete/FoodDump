module ApplicationHelper
  def fetch_recipes(search_term)
    Yummly.search(search_term).map { |recipe| recipe }
  end

  def choose_recipe(recipes)
    recipes[0]
  end

  def is_plural?(str)
    str.pluralize == str and str.singularize != str
  end
end
