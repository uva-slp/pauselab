#= require pages

describe "pages", ->

    beforeAll (done) ->

      fixture.load "pages.html", "ideas.json", "categories.json", append=true

      this.g = {
        ne: {
          lat: 38.042987,
          lng: -78.480079
        },
        sw: {
          lat: 38.0293,
          lng: -78.4767
        },
        ideas: fixture.json.filter((item) -> return Array.isArray(item))[0],
        categories: fixture.json.filter((item) -> return item[311] != "undefined")[0]
      }

      # avoid multiple google maps sdk
      if typeof google == "undefined"
        $.getScript "https://maps.googleapis.com/maps/api/js?key=AIzaSyD4DSpVTh3mv6nZ9D3A9xUtdaX7YpScN28&libraries=places", ->
          done()
      else
        done()

    # beforeEach ->


    # afterEach ->
      # fixture.cleanup()

    it "initializes correctly", ->
      spyOn($, 'get')
      spyOn(Pages, 'showMap')
      spyOn(Pages, 'fillMap')
      Pages.initialize()
      expect($.get).toHaveBeenCalled()
      expect(Pages.showMap).toHaveBeenCalled()
      expect(Pages.fillMap).toHaveBeenCalled()

    it "shows map correctly",  ->
      map = Pages.showMap this.g
      expect(map).toBeDefined()

    it "fills map correctly", ->
      map = Pages.showMap this.g
      markers = Pages.fillMap map, this.g
      google.maps.event.trigger map, 'click'
      google.maps.event.trigger markers[0], 'click'
      expect(markers.length).toEqual this.g.ideas.length

    it "builds idea infobox correctly", ->
      idea = this.g.ideas[0]
      info = Pages.buildInfo idea
      expect(info.innerHTML).toContain idea.description.substring(0, 10)

    it "shares to facebook", ->
      spyOn(window, 'open')
      idea = this.g.ideas[0]
      info = Pages.buildInfo idea
      $('#fb-btn', info).click()
      # $('#twtr-btn', info).click()
      expect(window.open).toHaveBeenCalled()

    it "shares to twitter", ->
      spyOn(window, 'open')
      idea = this.g.ideas[0]
      info = Pages.buildInfo idea
      # $('#fb-btn', info).click()
      $('#twtr-btn', info).click()
      expect(window.open).toHaveBeenCalled()

    it "formats description correctly", ->
      idea = this.g.ideas[0]
      fmt = Pages.format idea
      expect(fmt).toContain "more at:"
