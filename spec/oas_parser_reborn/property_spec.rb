RSpec.describe OasParser::Property do
  before do
    @definition = OasParser::Definition.resolve('spec/fixtures/petstore-expanded.yml')
    @path = @definition.path_by_path('/pets')
    @endpoint = @path.endpoint_by_method('post')
    @request_body = @endpoint.request_body
    @property = @request_body.properties_for_format('application/json')[0]
  end

  describe '#owner' do
    it 'returns the parent in this case the endpoint' do
      expect(@property.owner).to eq(@request_body)
    end
  end

  describe '#required' do
    it 'returns a boolean' do
      expect(@property.name).to eq('name')
      expect(@property.required).to eq(true)

      allow(@property).to receive(:schema) { { required: [] } }
      expect(@property.required).to eq(false)
    end

    context 'with nested objects' do
      before do
        @definition = OasParser::Definition.resolve('spec/fixtures/voice.yml')
        @path = @definition.path_by_path('/')
        @endpoint = @path.endpoint_by_method('post')
        @request_body = @endpoint.request_body
        @schemas = @request_body.split_properties_for_format('application/json')
      end

      it 'marks the right properties as required' do
        to = @schemas[0][1]
        expect(to.name).to eq('to')
        expect(to.required).to eq(true)

        from = @schemas[0][2]
        expect(from.name).to eq('from')
        expect(from.required).to eq(false)

        expect(from.properties[0].name).to eq('type')
        expect(from.properties[0].required).to eq(true)
        expect(from.properties[1].name).to eq('number')
        expect(from.properties[1].required).to eq(false)
      end
    end
  end

  describe '#type' do
    it 'returns the property type' do
      expect(@property.type).to eq('string')
    end
  end

  describe '#array?' do
    context 'when the type is array' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'array' }
        expect(@property.array?).to eq(true)
      end
    end

    context 'when the type is not array' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'foo' }
        expect(@property.array?).to eq(false)
      end
    end
  end

  describe '#object?' do
    context 'when the type is object' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'object' }
        expect(@property.object?).to eq(true)
      end
    end

    context 'when the type is not object' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'foo' }
        expect(@property.object?).to eq(false)
      end
    end
  end

  describe '#collection?' do
    context 'when the type is array' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'object' }
        expect(@property.collection?).to eq(true)
      end
    end

    context 'when the type is object' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'array' }
        expect(@property.collection?).to eq(true)
      end
    end

    context 'when the type is not object' do
      it 'returns true' do
        allow(@property).to receive(:type) { 'foo' }
        expect(@property.collection?).to eq(false)
      end
    end
  end

  describe '#properties' do
    before do
      @definition = OasParser::Definition.resolve('spec/fixtures/petstore-nested.yml')
      @path = @definition.path_by_path('/pets')
      @endpoint = @path.endpoint_by_method('post')
      @request_body = @endpoint.request_body
      @properties = @request_body.properties_for_format('application/json')
      @location_property = @properties[2]
      @attributes_property = @properties[3]
    end

    it 'can be used to return collection properties' do
      expect(@location_property.properties[0].class).to eq(OasParser::Property)
      expect(@location_property.properties[0].name).to eq('latitude')
      expect(@location_property.properties[0].type).to eq('string')

      expect(@attributes_property.properties[0].class).to eq(OasParser::Property)
      expect(@attributes_property.properties[0].name).to eq('id')
      expect(@attributes_property.properties[0].type).to eq('string')
    end

    context 'when the property is an array with anyOf' do
      before do
        @definition = OasParser::Definition.resolve('spec/fixtures/petstore-oneof-properties.yml')
        @path = @definition.path_by_path('/cards')
        @endpoint = @path.endpoint_by_method('post')
        @request_body = @endpoint.request_body
        @properties = @request_body.properties_for_format('application/json')
        @cards_property = @properties[0]

        puts @card_property
      end

      it 'can be used to return collection properties' do
        expect(@cards_property.name).to eq('cards')
        expect(@cards_property.type).to eq('array')
        expect(@cards_property.subproperties_are_one_of_many?).to eq(true)
        expect(@cards_property.properties.class).to eq(Array)
        expect(@cards_property.properties[0].class).to eq(Hash)
        expect(@cards_property.properties[0]['description']).to eq('Playing Card')
        expect(@cards_property.properties[1]['description']).to eq('Baseball Card')
        expect(@cards_property.properties[0]['properties'][0].class).to eq(OasParser::Property)
        expect(@cards_property.properties[0]['properties'].size).to eq(2)
        expect(@cards_property.properties[0]['properties'][0].name).to eq('rank')
      end
    end
  end
end
