import Foundation
import UIKit
@available(iOS 11.0, *)
extension LandingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 4;
  }
  
  
  //UICollectionViewDatasource methods
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (bookMarkList.count == 0) ? 1 : bookMarkList.count
  }
  

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {

    let width = collectionView.frame.width
    var height = (collectionView.bounds.height - (insideSpace * CGFloat(max(6, 1) - 1)))/CGFloat(6)
    if bookMarkList.count == 0 {
        height = collectionView.frame.height
    }
    return CGSize(width: width, height: height)
  }
//
//  public func collectionView(_ collectionView: UICollectionView,
//                             layout collectionViewLayout: UICollectionViewLayout,
//                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return insideSpace
//  }
//
//  public func collectionView(_ collectionView: UICollectionView,
//                             layout collectionViewLayout: UICollectionViewLayout,
//                             insetForSectionAt section: Int) -> UIEdgeInsets {
//    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//  }
//
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WeatherCell
//    let emptyMessageView = ShowEmptyMessageView()
//    //var emptyMessageView = FavouritesView()
//    cell.addSubview(emptyMessageView)
//
    if bookMarkList.count == 0 {
        cell.showEmptyView = true
    } else {
        cell.showEmptyView = false
        cell.backgroundColor = .red
        cell.celltitle.text = bookMarkList[indexPath.row]
    }
    return cell
  }
}


class WeatherCell: UICollectionViewCell {
    @IBOutlet weak var celltitle: UILabel!
    @IBOutlet weak var emptyImgView: UIImageView!
    @IBOutlet weak var emptyTextLabel: UILabel!
    
    var showEmptyView : Bool = false {
        didSet {
            celltitle.isHidden = showEmptyView
            emptyImgView.isHidden = !showEmptyView
            emptyTextLabel.isHidden = !showEmptyView
        }
    }
    
}
