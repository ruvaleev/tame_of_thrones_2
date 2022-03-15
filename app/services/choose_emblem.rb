# frozen_string_literal: true

class ChooseEmblem
  attr_accessor :game_set_id

  EMBLEMS = [
    { emblem_en: 'Gorilla', emblem_ru: 'Горилла' },
    { emblem_en: 'Panda', emblem_ru: 'Панда' },
    { emblem_en: 'Octopus', emblem_ru: 'Осьминог' },
    { emblem_en: 'Mammoth', emblem_ru: 'Маммонт' },
    { emblem_en: 'Owl', emblem_ru: 'Сова' },
    { emblem_en: 'Dragon', emblem_ru: 'Дракон' },
    { emblem_en: 'Dolphin', emblem_ru: 'Дельфин' },
    { emblem_en: 'Mosquito', emblem_ru: 'Комар' },
    { emblem_en: 'Cheburashka', emblem_ru: 'Чебурашка' },
    { emblem_en: 'Squid', emblem_ru: 'Кальмар' },
    { emblem_en: 'Monkey', emblem_ru: 'Обезьяна' },
    { emblem_en: 'Mantis', emblem_ru: 'Богомол' },
    { emblem_en: 'Stork', emblem_ru: 'Аист' },
    { emblem_en: 'Cat', emblem_ru: 'Кошка' },
    { emblem_en: 'Wasp', emblem_ru: 'Оса' },
    { emblem_en: 'Bull', emblem_ru: 'Бык' },
    { emblem_en: 'Elephant', emblem_ru: 'Слон' },
    { emblem_en: 'Wolf', emblem_ru: 'Волк' },
    { emblem_en: 'Crab', emblem_ru: 'Краб' },
    { emblem_en: 'Bear', emblem_ru: 'Медведь' },
    { emblem_en: 'Hyena', emblem_ru: 'Гиена' },
    { emblem_en: 'Raven', emblem_ru: 'Ворон' },
    { emblem_en: 'Bat', emblem_ru: 'Летучая мышь' },
    { emblem_en: 'Snail', emblem_ru: 'Улитка' },
    { emblem_en: 'Crocodile', emblem_ru: 'Крокодил' },
    { emblem_en: 'Lion', emblem_ru: 'Лев' },
    { emblem_en: 'Eagle', emblem_ru: 'Орёл' },
    { emblem_en: 'Horse', emblem_ru: 'Лошадь' },
    { emblem_en: 'Mouse', emblem_ru: 'Мышь' },
    { emblem_en: 'Rhinoceros', emblem_ru: 'Носорог' },
    { emblem_en: 'Penguin', emblem_ru: 'Пингвин' }
  ].freeze

  def initialize(game_set_id)
    @game_set_id = game_set_id
  end

  def run
    emblems = find_uniq_emblems
    { ru: emblems[:emblem_ru], en: emblems[:emblem_en] }
  end

  private

  def find_uniq_emblems
    loop do
      emblems = EMBLEMS.sample
      break emblems if Kingdom.find_by(emblem_en: emblems[:emblem_en], game_set_id: game_set_id).nil?
    end
  end
end
