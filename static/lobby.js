var App = new Mn.Application();

App.addRegions({
    headReg: "#head-reg",
    newGameReg: "#new-game-reg",
    ownedReg: "#owned-games-reg",
    joinedReg: "#joined-games-reg",
    otherReg: "#other-games-reg"
})

App.on("start",function(){
    var headView = new App.HeadView();
    var newGameView = new App.NewGameView();
    var ownedView = new App.GameListView({collection:ownedgames});
    var joinedView = new App.GameListView({collection:joinedgames});
    var otherView = new App.GameListView({collection:othergames});
    App.headReg.show(headView);
    App.newGameReg.show(newGameView);
    App.ownedReg.show(ownedView);
    App.joinedReg.show(joinedView);
    App.otherReg.show(otherView);

    Backbone.history.start();
});

App.HeadView = Mn.ItemView.extend({
    template: "#head-template",
    modelEvents: {
	"change":"render"
    }
});

App.NewGameView = Mn.ItemView.extend({
    template: "#new-game-template",
    modelEvents: {
	"change":"render"
    }
});

App.GameListEntryView = Mn.ItemView.extend({
    template: "#game-list-entry-template",
    initialize: function() {
	this.render();
    },
    events: {},
    modelEvents: {
	"change":"render"
    }
});

App.GameListView = Mn.CollectionView.extend({
    template: "#game-list-template",
    childView: App.GameListEntryView,
    childViewContainer: "div#game-list-div",
    initialize: function() {
	this.render();
    },
    events: {},
    modelEvents: {
	"change":"render"
    }
});

var GameListEntry = Backbone.Model.extend({});
var GameList = Backbone.Collection.extend({
    model:GameListEntry,
    //comparator:function(){return <somesortofidthing???>;}
});

var ownedgames = new GameList();
var joinedgames = new GameList();
var othergames = new GameList();

function addEntriesToCollection(lst,coll) {
    for(var i=0; i<lst.length; i++) {
	coll.add(new GameListEntry(lst[i]));
    }
}

App.addInitializer(function() {
    $.getJSON("/ajax/gamelist/"+USERNAME,function(gamelistjson){
	addEntriesToCollection(gamelistjson.ownedgames,ownedgames);
	addEntriesToCollection(gamelistjson.joinedgames,joinedgames);
	addEntriesToCollection(gamelistjson.othergames,othergames);
    });
});

App.start();
