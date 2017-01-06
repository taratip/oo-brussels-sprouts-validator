class Ingredient
  VALID_INGREDIENTS = [
    'brussels sprouts',
    'spinach',
    'eggs',
    'milk',
    'tofu',
    'seitan',
    'bell peppers',
    'quinoa',
    'kale',
    'chocolate',
    'beer',
    'wine',
    'whiskey'
  ]

  attr_reader :quantity, :unit, :name
  def initialize(quantity,unit,name)
    @quantity = quantity.to_f
    @unit = unit
    @name = name.downcase
  end

  def safe?
      VALID_INGREDIENTS.include?(@name)
  end

  class << self
    def parse(ingredient_string)
      ingredient = ingredient_string.split(" ")
      quantity = ingredient[0].to_f
      unit = ingredient[1]
      name = ingredient[2..-1].join(" ")

      new(quantity,unit,name)
    end
  end
end

class Recipe
  attr_reader :name, :instructions, :ingredients

  def initialize(name, instructions, ingredients)
    @name = name
    @instructions = []
    instructions.each do |instruction|
      @instructions << instruction
    end
    @ingredients = []
    ingredients.each do |ingredient|
      @ingredients << ingredient.safe?
    end
  end

  def has_allergens?
    @ingredients.include?(false) ? "Not safe! Has allergens" : "Safe! Has no allergens"
  end
end

#For testing
safe_name = "Chocolate Quinoa"
safe_ingredients = [
        Ingredient.new(1.0, "cup", "quinoa"),
        Ingredient.new(1.0, "cup", "chocolate")
      ]
safe_instructions = [
        "Melt chocolate.",
        "Pour over quinoa.",
        "Regret your life."
      ]
safe_recipe = Recipe.new(safe_name, safe_instructions, safe_ingredients)
puts "Is #{safe_recipe.name} safe? #{safe_recipe.has_allergens?}"

sugar_cookies_recipe = "Easy sugar cookies"
unsafe_ingredients = [
        Ingredient.new(2.75, "cup(s)", "all-purpose floue"),
        Ingredient.parse("1 teaspoon baking sode"),
        Ingredient.new(0.5, "teaspoon", "baking powder"),
        Ingredient.parse("1 cup butter,softened"),
        Ingredient.new(1.5, "cup(s)", "white sugar"),
        Ingredient.new(1, "egg(s)", "egg")
      ]
instructions = [
        "Preheat oven to 375 degrees F (190 degrees C).",
        "n a small bowl, stir together flour, baking soda, and baking powder. Set aside.",
        "In a large bowl, cream together the butter and sugar until smooth.",
        "Beat in egg and vanilla. Gradually blend in the dry ingredients.",
        "Roll rounded teaspoonfuls of dough into balls, and place onto ungreased cookie sheets.",
        "Bake 8 to 10 minutes in the preheated oven, or until golden.",
        "Let stand on cookie sheet two minutes before removing to cool on wire racks."
      ]
unsafe_recipe = Recipe.new(sugar_cookies_recipe, instructions, unsafe_ingredients)
puts "Is #{unsafe_recipe.name} safe? #{unsafe_recipe.has_allergens?}"
