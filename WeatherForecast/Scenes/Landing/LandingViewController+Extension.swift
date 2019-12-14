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
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WeatherCell
    
    if bookMarkList.count == 0 {
      cell.showEmptyView = true
    } else {
      cell.showEmptyView = false
      var viewForCell = TodayView()
      cell.todayView = viewForCell
    }
    return cell
  }
}


class WeatherCell: UICollectionViewCell {
  @IBOutlet weak var emptyImgView: UIImageView!
  @IBOutlet weak var emptyTextLabel: UILabel!
  @IBOutlet weak var todayView: TodayView!
  
  var showEmptyView : Bool = false {
    didSet {
      todayView.isHidden = !showEmptyView
      emptyImgView.isHidden = !showEmptyView
      emptyTextLabel.isHidden = !showEmptyView
    }
  }
  
  
  
}
