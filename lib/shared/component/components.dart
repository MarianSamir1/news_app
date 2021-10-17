import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

Widget newsComponent(artical , context){
  return  InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>WebViewScreen(artical['url'])));
    },
    child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: 
                [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: artical['urlToImage']!=null? NetworkImage('${artical['urlToImage']}'): NetworkImage("https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512_960_720.jpg"),
                  )),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 120,
                    width: 120,
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: 
                      [
                        Expanded(
                          child: Text('${artical['title']}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1
                          ),
                        ),
                        Text('${artical['publishedAt']}',
                        style: TextStyle(
                          color: Colors.grey
                        ),)
                      ],
                    ),
                  ),
                )
              ]),
            ),
  ); 
}

Widget myDivider(){
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 10),
    child: Container(
      height: 2,
      color: Colors.grey[300],
    ),
  );
}

Widget customTextFormFeild({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required Icon prefixIcon,
  required String label,
  Icon? suffixIcon,
  Function? onChange,
  Function? suffixPressed,
  bool obscure = false,
  String? error,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (value){
        onChange!(value);
      },
      obscureText: obscure,
      validator: (s) {
        if (s!.isEmpty) {
          return error;
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey
        ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: suffixIcon)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: label),
    );



