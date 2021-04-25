class StringUtils{
    static int getPhotoIdFromUrl(String url){
        if (url == null || url.isEmpty)
          return 0;
        //https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg
        final uri = Uri.parse(url);
        var uriSegments = uri.pathSegments;
        if(uriSegments == null || uriSegments.isEmpty || uriSegments.length < 2)
          return 0;
        return int.parse(uriSegments[1]);
    }
}