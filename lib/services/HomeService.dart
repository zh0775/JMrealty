class HomeService {
  String url() => null;
  Future<dynamic> getHomeBanner() async {
    return Map.of({
      'code': 0,
      'data': [
        {
          'imgUrl':
              'http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/64/w1024h640/20181024/wBkr-hmuuiyw6863395.jpg'
        },
        {
          'imgUrl':
              'http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/99/w1024h675/20181024/FGXD-hmuuiyw6863401.jpg'
        },
        {
          'imgUrl':
              'http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/107/w1024h683/20181024/kZj2-hmuuiyw6863420.jpg'
        },
        {
          'imgUrl':
              'http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/105/w1024h681/20181024/tOiL-hmuuiyw6863462.jpg'
        }
      ]
    });
  }
}
