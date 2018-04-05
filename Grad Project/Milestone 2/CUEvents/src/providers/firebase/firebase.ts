import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { Observable } from 'rxjs/Observable';
import { AngularFireDatabase } from 'angularfire2/database'

/*
  Generated class for the FirebaseProvider provider.

  See https://angular.io/guide/dependency-injection for more info on providers
  and Angular DI.
*/
@Injectable()
export class FirebaseProvider {

  constructor(public db: AngularFireDatabase) {
    console.log('Hello FirebaseProvider Provider');
  }

  getEvents()
  {
    return  this.db.list('events').valueChanges();
  }

  // addEvent(eventTitle)
  // {
  //   this.db.list('events').push({'title': eventTitle})
  // }

  addEvent(values)
  {
    console.log(JSON.stringify(values))
    // this.db.list('events').push({'title': values})
    this.db.list('events').push({
      'title': values.title, 
      'desc': values.desc,
      'startdate': values.startdate,
      'enddate': values.enddate,
      'starttime': values.starttime,
      'endtime': values.endtime,
      'address': values.address,
      'publicorreg': values.publicorreg,
      'cat': values.catid,
      'target': values.targetid,
      'city': values.cityid

    })

  }

  getCategories()
  {
    return this.db.list('categories').valueChanges();
  }

  getCities()
  {
    return this.db.list('cities').valueChanges();
  }

  getAudience()
  {
    return this.db.list('audience').valueChanges();
  }
  // addEvent(event)
  // {
  //   this.db.list('events').push({title: }})
  // }

}
