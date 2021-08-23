import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';

class MovieSlider extends StatefulWidget {

    final String? title;
    final List<Movie> movie;
    final Function onNextPage;

  const MovieSlider(
    {
      Key? key,
      this.title,
      required this.movie,
      required this.onNextPage,
    }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
    print('papa');

    scrollController.addListener(() { 
        double _position = scrollController.position.pixels;
        double _max = scrollController.position.maxScrollExtent;
      if(_position == _max){
        // print('joder, llego');
        widget.onNextPage();
      }

    });
  }

  @override
  void dispose(){
    super.dispose();
    // scrollController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('${this.widget.title}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold )),
            ), 

          SizedBox(height:5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movie.length,
              itemBuilder: ( _, int index) => _MoviePoster(widget.movie[index], '${widget.title}-$index-${widget.movie[index].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  //TODO
  final Movie movie;
  final String heroId;

  const _MoviePoster( this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'popular';

    return Container(
                  width: 130,
                  height: 190,
                  margin: EdgeInsets.symmetric(horizontal:10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context,'details',arguments:movie),
                        child: Hero(
                          tag: heroId,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder: AssetImage('lib/assets/no-image.jpg'),
                              image: NetworkImage (movie.fullPosterImg ),
                              width: 130,
                              height: 190,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5)
                    ],
                  )
                );
  }
}