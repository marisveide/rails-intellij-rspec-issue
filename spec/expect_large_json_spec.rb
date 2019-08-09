describe 'Large JSON' do


  it 'should compare small JSON against himself and pass' do
    expected_hash = {id: 123, format: 'Test'}
    actual_hash = expected_hash.deep_dup

    expect(JSON.pretty_generate(actual_hash)).to eq(JSON.pretty_generate(expected_hash))
  end


  it 'should compare small JSON against another and fail properly' do
    expected_hash = {id: 123, format: 'Test'}

    actual_hash = expected_hash.deep_dup
    actual_hash[:format] = 'Something Else'

    expect(JSON.pretty_generate(actual_hash)).to eq(JSON.pretty_generate(expected_hash))
  end


  it 'should compare large JSON against another and not pass nor fail - reproduce the IntelliJ issue' do
    expected_json_file_path = "#{Rails.root}/spec/fixtures/large.json"
    expected_hash = JSON.parse(File.read(expected_json_file_path)).with_indifferent_access

    actual_hash = expected_hash.deep_dup
    actual_hash[:friends] = []

    expect(JSON.pretty_generate(actual_hash)).to eq(JSON.pretty_generate(expected_hash))
  end

end
