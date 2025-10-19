class ProfileDefinition < ::ResourceDefinition
  input :skillsets, as: :slim_select, multiple: true, choices: Profile::SKILLSETS.invert
  input :sex, choices: Profile::SEXES.invert
  display :sex, formatter: ->(value) { value.titleize }
  display :skillsets, wrapper: {class: "col-span-full"} do |a|
    p(class: "string value text-md text-gray-900 dark:text-white mb-1 whitespace-pre-line") {
      Profile::SKILLSETS.invert.slice(*a.value).values.join ", "
    }
  end
end
