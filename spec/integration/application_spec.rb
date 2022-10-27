require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it "returns all albums" do
      response = get('/albums')

      expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

      expect(response.status).to eq(200)
      #expect(response.body).to include('<div>
       #               Title: Surfer Rosa
        #              <br>
         #             Released: 1988
          #          </div>')
    end
  end

  context 'GET /albums/new' do
    it 'should returns the form to add a new album' do
      response = get('albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">' )
      expect(response.body).to include('<input type="text" name="title"/>')
      expect(response.body).to include('<input type="text" name="release_year"/>')
      expect(response.body).to include('<input type="text" name="artist_id"/>')
    end
  end

  context 'GET /artists/new' do
    it 'should returns the form to add a new album' do
      response = get('artists/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/artists">' )
      expect(response.body).to include('<input type="text" name="name"/>')
      expect(response.body).to include('<input type="text" name="genre"/>')
    end
  end

  context 'POST /albums' do
    it "creates new album" do
    response = post(
      '/albums',
      title: 'OK Computer',
      release_year: '1997',
      artist_id: '1'
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')

      expect(response.body).to include('OK Computer')
    end
    it "creates new album" do
      response = post(
        '/albums',
        title: 'Voyage',
        release_year: '2022',
        artist_id: '2'
        )
  
        expect(response.status).to eq(200)
        expect(response.body).to eq('')
  
        response = get('/albums')
  
        expect(response.body).to include('Voyage')
      end

      context "/artists" do
        xit "returns all the artists" do
          response = get('/artists')

          expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

          expect(response.status).to eq(200)
          expect(response.body).to eq(expected_response)
        end
        it "creates new artist" do
          response = post(
            '/artists',
            name: 'Wild nothing',
            genre: 'Indie',
            )
      
            expect(response.status).to eq(200)
            expect(response.body).to eq('')
      
            response = get('/artists')
      
            expect(response.body).to include('Wild nothing')
            added = get('/artists')

            expect(response.body).to include('Pixies')
          end
      end
  end 
  context "GET to /" do
    it 'contains a h1 title' do
      response = get('/')
  
      expect(response.body).to include('<h1>Hello !</h1>')
    end
    
    it 'contains a div' do
      response = get('/')
  
      expect(response.body).to include('<div>')
    end
  end
  context "GET to /hello" do
    it 'contains a h1 title' do
      response = get('/hello')
  
      expect(response.body).to include('<h1>Hello !</h1>')
    end
    
    it 'contains a div' do
      response = get('/')
  
      expect(response.body).to include('<div>')
    end
  end

  context "GET /albums/:id" do
    xit 'should return info about album 1' do
      response = get('/albums/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('1989')
      expect(response.body).to include('Pixies')
    end
  end

  it 'return links for all albums' do
    response = get('/albums')

    expect(response.status).to eq(200)    
    expect(response.body).to include('')

  end
  it 'return links for all artists' do
    response = get('/artists')

    expect(response.status).to eq(200)    
    expect(response.body).to include('<a href="http://localhost:9292/artists/1">Pixies</a>')

  end

  xit 'should return info about artist 1' do
    response = get('/albums/1')

    expect(response.status).to eq(200)
    expect(response.body).to include('Pixies')
    expect(response.body).to include('Rock')

  end
end
