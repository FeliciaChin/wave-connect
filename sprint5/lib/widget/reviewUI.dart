// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:new_pro/Page/models/reviewModal.dart';
// import '../Page/rating_page.dart';

// class ReviewUI extends StatelessWidget {
//   final ReviewModal review;
//   ReviewUI({
//     Key? key,
//       required this.review,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container (
//           padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 16.0, right: 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row (
//                 children: [
//                   Container(
//                     margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
//                     width: MediaQuery.of(context).size.width * 0.12,
//                     height: MediaQuery.of(context).size.height * 0.05,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(25)),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage(review.image),
//                       )
//                     ),
//                   ),
//                   Expanded (
//                     child: Text(
//                       review.name, 
//                       style: TextStyle(
//                         fontSize: 20.0, 
//                         fontWeight: FontWeight.bold
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: (){}, 
//                     icon: Icon(Icons.more_vert),
//                   ),
//                 ]
//               ),
//               SizedBox(height: 5),
//               Row(
//                children: [
//                  RatingBar(
//                   initialRating: review.rating,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 28,
//                   ignoreGestures: true,
//                   ratingWidget: RatingWidget(
//                   full: const Icon(
//                     Icons.star, 
//                     color: Colors.orange
//                   ),
//                   half: const Icon(
//                     Icons.star_half,
//                     color: Colors.orange,
//                   ),
//                   empty: const Icon(
//                     Icons.star_border_outlined,
//                     color: Colors.orange,
//                   ),
//                  ), 
//                   onRatingUpdate: (value) {},
//                   ),
//                   SizedBox(width: 20),
//                   Text(
//                     review.date, 
//                     style: TextStyle(fontSize: 16)
//                   ),
//                ],
//               ),  
//               SizedBox(height: 5),
//               GestureDetector(
//                 onTap: () { 
//                        Navigator.of(context)
//                        .pop(MaterialPageRoute(builder: (context) => RatingPage()));
//                       } ,
//                 child: Row(
//                   children: [
//                     SizedBox(width: 7),
//                     Container(
//                       width: 350,
//                       child: Text(
//                         review.comment,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black,
//                         ),
//                       ):
//                       Text(
//                         review.comment,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black,
//                         ),
//                       )
//                     ),
//                   ],
//                 ),
//               ),       
//             ],
//           )
//         );

//   }
// }

