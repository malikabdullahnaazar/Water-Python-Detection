// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import "package:flutter/material.dart";
import "package:water_pathogen_detection_system/Screens/Blogs/SingleBlog.dart";

class BlogsCard extends StatefulWidget {
  final snap;

  const BlogsCard({
    this.snap,
    super.key,
  });

  @override
  State<BlogsCard> createState() => _BlogsCardState();
}

class _BlogsCardState extends State<BlogsCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleBlog(
                              photoUrl: widget.snap["PostUrl"],
                              title: widget.snap["Description"],
                              description: widget.snap["Title"])));
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.snap["PostUrl"] ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 2,
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap["Title"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      widget.snap["Description"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Container(
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Posted: 23/12/2021",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  size: 23,
                                  color: Colors.black,
                                )),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
