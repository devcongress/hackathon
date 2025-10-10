class ProfileDefinition < ::ResourceDefinition
  input :skillsets, as: :slim_select, multiple: true, choices: Profile::SKILLSETS.invert
  input :sex, choices: Profile::SEXES.invert
  display :skillsets, wrapper: {class: "col-span-full"} do |a|
    Profile::SKILLSETS.invert.slice(*a.value).values.join ", "
  end
end
