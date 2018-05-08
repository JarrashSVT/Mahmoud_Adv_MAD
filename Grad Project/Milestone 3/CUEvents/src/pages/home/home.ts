import { Component } from '@angular/core';
import { NavController, LoadingController } from 'ionic-angular';
import { Observable } from 'rxjs/Observable';
// import { AngularFireDatabase } from 'angularfire2/database'
import { FirebaseProvider } from '../../providers/firebase/firebase'
import { EventDatailsPage } from '../../pages/event-datails/event-datails'
 
@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  events: Observable<any[]>;
  categories: Observable<any[]>;
  cities: Observable<any[]>;
  audience:Observable<any[]>;
  newEvent: any;
  loader: any;
  eventDetailsPage: any;

  categoriesIterator: IterableIterator<any>;
  categoriesArray: any[];

  catid: string;
  townid: string;
  targetid: string;

  constructor(public navCtrl: NavController, public firebaseProvider: FirebaseProvider, private loadingCtrl: LoadingController)
  {
    console.log('constructor')
    this.eventDetailsPage = EventDatailsPage;
    this.loader = this.loadingCtrl.create({
      content: "Loading"
    })
    //this.events = db.list('events').valueChanges();
    this.events = this.firebaseProvider.getEvents();
    this.categories = this.firebaseProvider.getCategories();
    this.cities = this.firebaseProvider.getCities();
    this.audience = this.firebaseProvider.getAudience();
    this.catid = "All";
    this.targetid = "All";
    this.townid = "All";

    if(this.events && this.categories)
    {
      if(this.loader)
      {
        this.loader.dismiss()
        this.loader = null
      }
    }

    
    // this.categories.subscribe(data => {
    //   //console.log(data);
    //   var catArray = data;

    //   catArray.forEach(element => console.log(element))
    //   this.categoriesArray = Array.from(catArray.values())
    // }) 

    // this.categoriesArray = Array.from(this.categoriesIterator.)
  }


  ionViewDidEnter() {
    if (this.loader) {
      this.loader.present();
    }
  }

  addEvent()
  {
    this.firebaseProvider.addEvent(this.newEvent)
  }

}
