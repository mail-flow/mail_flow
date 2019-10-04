shared_examples 'snake cased field name' do |options = {}|
  model = options[:model]

  describe 'validation' do
    it 'name should be present' do
      expect(build(model, name: nil)).not_to be_valid
    end

    it 'name should be at least 3 characters' do
      expect(build(model, name: 'ab')).not_to be_valid
      expect(build(model, name: 'abc')).to be_valid
    end

    it 'name should be snake cased' do
      expect(build(model, name: 'abc_def')).to be_valid
      expect(build(model, name: 'Abc_Def')).not_to be_valid
      expect(build(model, name: 'Abc def')).not_to be_valid
      expect(build(model, name: 'ABC')).not_to be_valid
    end

    it 'name should not have numbers and special characters' do
      expect(build(model, name: '123')).not_to be_valid
      expect(build(model, name: 'abc123')).to be_valid
      expect(build(model, name: 'abc-def')).not_to be_valid
      expect(build(model, name: 'a%d')).not_to be_valid
    end

    it 'name should be unique' do
      create(model, name: 'abc')
      expect(build(model, name: 'abc')).not_to be_valid
    end
  end
end
