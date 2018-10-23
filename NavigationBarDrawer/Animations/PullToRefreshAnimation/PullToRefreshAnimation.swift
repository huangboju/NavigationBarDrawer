//
//  PullToRefreshAnimation.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/7/14.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

class PullToRefreshAnimation: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var items: [String] = []
    
    var isLoading = true
    
    var loadingIndicator: UIView!
    /** The layer that is animated as the user pulls down */
    var pullToRefreshShape: CAShapeLayer!
    
    /** The layer that is animated as the app is loading more data */
    var loadingShape: CAShapeLayer!

    private lazy var collectionView: UICollectionView = {
        let layout = PrimeFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let side = (self.view.frame.width - 50) / 3
        layout.itemSize = CGSize(width: side, height: side)
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        setupLoadingIndicator()
        
        pullToRefreshShape.add(pullDownAnimation, forKey: "Write 'Load' as you drag down")

        fetchMoreData {
            self.isLoading = false
        }
    }

    /**
     Two stroked shape layers that form the text 'Load' and 'ing'
     */
    func setupLoadingIndicator() {
        let loadShape = CAShapeLayer()
        loadShape.path = loadPath
        
        let ingShape  = CAShapeLayer()
        ingShape.path  = ingPath
        
        let loadingIndicator = UIView(frame: CGRect(x: 0, y: -45, width: 230, height: 70))
        collectionView.addSubview(loadingIndicator)
        
        self.loadingIndicator = loadingIndicator

        for shape in [loadShape, ingShape] {
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor   = UIColor.clear.cgColor
            shape.lineCap   = CAShapeLayerLineCap.round
            shape.lineJoin  = CAShapeLayerLineJoin.round
            shape.lineWidth = 5.0
            shape.position = CGPoint(x: 75, y: 0)
            shape.strokeEnd = 0
            loadingIndicator.layer.addSublayer(shape)
        }

        loadShape.speed = 0 // pull to refresh layer is paused here
        
        pullToRefreshShape = loadShape
        loadingShape       = ingShape
    }
    
    /**
     This is the animation that is controlled using timeOffset when the user pulls down
     */
    var pullDownAnimation: CAAnimationGroup {
        // Text is drawn by stroking the path from 0% to 100%
        
        let writeText = CABasicAnimation(keyPath: "strokeEnd")
        writeText.fromValue = 0
        writeText.toValue = 1
        
        // The layer is moved up so that the larger loading layer can fit above the cells
        let move = CABasicAnimation(keyPath: "position.y")
        move.byValue = -22
        move.toValue = 0
        
        let group = CAAnimationGroup()
        group.duration = 1.0 // For convenience when using timeOffset to control the animation
        group.animations = [writeText, move]
        return group
    }
    
    /**
     The loading animation is quickly drawing the last the letters (ing)
     */
    var loadingAnimation: CABasicAnimation {
        let write2 = CABasicAnimation(keyPath: "strokeEnd")
        write2.fromValue = 0
        write2.toValue   = 1
        write2.fillMode = CAMediaTimingFillMode.both
        write2.isRemovedOnCompletion = false
        write2.duration = 0.4
        return write2
    }
    
    var loadPath: CGPath? {
        let path = CGMutablePath()
        // load
        path.move(to: CGPoint(x: 7.50878897, y: 25.2871097))
        path.addCurveToPoint(7.50878897, 25.2871097,  21.7333976, 26.7812495, 29.6894527, 20.225586)
        path.addCurveToPoint(37.6455074, 13.6699219,  39.367189,  3.85742195, 31.9697262, 1.25976564)
        path.addCurveToPoint(24.5722639, -1.33789083, 21.99707,   10.9072268, 21.99707,   22.2255862)
        path.addCurveToPoint(21.9970685, 33.5439456,  15.9355469, 45.8212894, 8.99707031, 47.7294922)
        path.addCurveToPoint(2.05859375, 49.637695,   3.67187498, 44.0332034, 7.50878897, 44.0332034)
        path.addCurveToPoint(11.3457029, 44.0332034,  16.9277345, 44.234375,  25.5234372, 47.7294925)
        path.addCurveToPoint(30.55635,   49.7759358,  37.9023439, 49.5410159, 44.1259762, 35.9140628)
        path.addCurveToPoint(50.349609,  22.2871097,  55.3105465, 25.2871099, 60.7128903, 25.2871097)
        path.addCurveToPoint(66.481445,  25.2871097,  56.192383,  22.6435549, 50.8017578, 26.6455078)
        path.addCurveToPoint(45.4111325, 30.6474606,  43.4619148, 37.8193362, 46.0097656, 43.7333984)
        path.addCurveToPoint(48.5576169, 49.6474606,  57.0488304, 50.0810555, 61.8876968, 43.0097659)
        path.addCurveToPoint(66.7265637, 35.9384765,  65.6816424, 31.5634772, 64.4834,    27.8232425)
        path.addCurveToPoint(63.2851574, 24.0830078,  59.8876972, 27.8076178, 59.8876968, 31.4882815)
        path.addCurveToPoint(59.8876965, 35.1689453,  69.1025406, 37.2509768, 74.9531265, 32.7333987)
        path.addCurveToPoint(80.8037132, 28.2158207,  80.1298793, 27.0527347, 84.4970703, 25.3574219)
        path.addCurveToPoint(88.8642613, 23.6621091,  93.7460906, 25.37793,   96.1650391, 28.8349609)
        path.addCurveToPoint(96.1650391, 28.8349609,  91.6679688, 24.28711,   88.085941,  24.2871097)
        path.addCurveToPoint(84.5039132, 24.2871093,  74.9824181, 33.0332029, 78.5166016, 43.3417969)
        path.addCurveToPoint(82.0507847, 53.6503909,  92.167965,  42.5078128, 95.0117188, 38.9140625)
        path.addCurveToPoint(97.8554722, 35.3203122,  100.327144, 27.9042972, 100.327148, 23.3740234)
        path.addCurveToPoint(100.327152, 18.8437497,  96.499996,  26.5527347, 96.5,       32.7333984)
        path.addCurveToPoint(96.5000035, 38.9140622,  92.6337871, 53.1660163, 101.700195, 46.0400391)
        path.addCurveToPoint(110.766605, 38.9140622,  112.455075, 29.5751958, 118.345703, 26.9746094)
        path.addCurveToPoint(124.236332, 24.3740231,  129.221685, 27.5800787, 131.216798, 30.1386722)
        path.addCurveToPoint(131.216798, 30.1386722,  125.394529, 25.9746094, 121.82422,  25.9746097)
        path.addCurveToPoint(118.253911, 25.9746099,  110.588871, 32.4130862, 112.661136, 41.7500003)
        path.addCurveToPoint(114.733402, 51.0869143,  119.810543, 48.9121097, 125.347656, 43.0097656)
        path.addCurveToPoint(130.884769, 37.1074216,  137.702153, 21.0126953, 139.335938, 12.4980469)
        path.addCurveToPoint(140.969722, 3.98339847,  140.637699,-2.27636688, 136.845703, 7.984375)
        path.addCurveToPoint(134.586089, 14.0986513,  131.676762, 31.5527347, 129.884769, 38.9140628)
        path.addCurveToPoint(128.092777, 46.2753909,  130.551236, 50.2217745, 135.211914, 46.2753906)
        path.addCurveToPoint(146.745113, 36.5097659,  142.116211, 40.75,      142.116211, 40.75)
        
        var t = CGAffineTransform(scaleX: 0.7, y: 0.7) // It was slighly to big and I didn't feel like redoing it :D
        return path.copy(using: &t)
    }
    
    var ingPath: CGPath? {
        let path = CGMutablePath()
        // ing (minus dot)
        path.move(to: CGPoint(x: 139.569336, y: 42.9423837))
        path.addCurveToPoint(139.569336, 42.9423837, 149.977539, 32.9609375, 151.100586, 27.9072266)
        path.addCurveToPoint(152.223633, 22.8535156, 149.907226, 21.5703124, 148.701172, 26.5419921)
        path.addCurveToPoint(147.495117, 31.5136718, 142.760742, 50.8046884, 149.701172, 48.2763681)
        path.addCurveToPoint(156.641602, 45.7480478, 166.053711, 33.5791017, 167.838867, 29.5136719)
        path.addCurveToPoint(169.624023, 25.4482421, 169.426758, 20.716797,  167.455078, 26.1152344)
        path.addCurveToPoint(165.483398, 31.5136718, 165.618164, 42.9423835, 163.97168,  48.2763678)
        path.addCurveToPoint(163.97168,  48.2763678, 163.897461, 41.4570313, 168.141602, 35.9375)
        path.addCurveToPoint(172.385742, 30.4179687, 179.773438, 21.9091796, 183.285645, 26.6875)
        path.addCurveToPoint(186.797851, 31.4658204, 177.178223, 48.2763684, 184.285645, 48.2763678)
        path.addCurveToPoint(191.393066, 48.2763678, 196.006836, 38.8701172, 198.850586, 34.0449218)
        path.addCurveToPoint(201.694336, 29.2197264, 207.908203, 19.020508,  216.71875,  28.4179687)
        path.addCurveToPoint(216.71875,  28.4179687, 211.086914, 23.5478516, 206.945312, 24.6738281)
        path.addCurveToPoint(202.803711, 25.7998046, 194.8125,   40.1455079, 201.611328, 47.2763672)
        path.addCurveToPoint(208.410156, 54.4072265, 220.274414, 30.9111327, 221.274414, 26.6874999)
        path.addCurveToPoint(222.274414, 22.4638672, 220.005859, 20.3759766, 218.523438, 28.5419922)
        path.addCurveToPoint(217.041016, 36.7080077, 216.630859, 64.7705084, 209.121094, 71.012696)
        path.addCurveToPoint(201.611328, 77.2548835, 197.109375, 65.0654303, 202.780273, 60.9287116)
        path.addCurveToPoint(208.451172, 56.7919928, 224.84668,  51.0244147, 228.638672, 38.6855466)
        
        // dot
        path.move(to: CGPoint(x: 153.736328, y: 14.953125))
        path.addCurveToPoint(153.736328, 14.953125,  157.674805, 12.8178626, 155.736328, 10.2929688)
        path.addCurveToPoint(153.797852, 7.76807493, 151.408203, 12.2865614, 152.606445, 14.9531252)
        
        var t = CGAffineTransform(scaleX: 0.7, y: 0.7) // It was slighly to big and I didn't feel like redoing it :D
        return path.copy(using: &t)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        (cell as? CustomCell)?.text = items[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.contentInset.top
        if offset <= 0.0 && !isLoading && isViewLoaded {
            let startLoadingThreshold: CGFloat = 60.0
            let fractionDragged: CGFloat = -offset / startLoadingThreshold
            
            pullToRefreshShape.timeOffset = min(1.0, Double(fractionDragged))
            
            if fractionDragged >= 1.0 {
                startLoading()
            }
        }
    }
    
    func startLoading() {
        isLoading = true

        // start the loading animation
        loadingShape.add(loadingAnimation, forKey: "Write that word")
        
        let contentInset = collectionView.contentInset.top
        // inset the top to keep the loading indicator on screen
        collectionView.contentInset = UIEdgeInsets(top: contentInset + loadingIndicator.frame.height, left: 0, bottom: 0, right: 0)
        collectionView.isScrollEnabled = false // no further scrolling
        
        loadMoreData(with: { 
            // during the reload animation (where new cells are inserted)
            self.collectionView.contentInset = UIEdgeInsets(top: contentInset, left: 0, bottom: 0, right: 0)
            self.loadingIndicator.alpha = 0.0
        }, completion: {
            // reset everything
            self.loadingShape.removeAllAnimations()
            self.loadingIndicator.alpha = 1.0
            self.collectionView.isScrollEnabled = true
            self.pullToRefreshShape.timeOffset = 0.0 // back to the start
            self.isLoading = false
        })
    }
    
    /**
     @note You shouldn't stall data fetching like this in a real app ;)
     */
    func loadMoreData(with animation: @escaping () -> Void, completion: @escaping () -> Void) {
        // I had to cheat a little because calculating 6 new primes is quite fast ;)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 0.3, animations: animation)
            self.fetchMoreData(with: completion)
        }
    }

    /**
     For conveience so that new data is both calculated and inserted into the collection
     before the completion block is run (after the insertions)
     */
    func fetchMoreData(with completion: @escaping () -> Void) {
        findMorePrimes { newItems, indexPaths in
            var _newItems = newItems
            _newItems.append(contentsOf: self.items)
            self.collectionView.performBatchUpdates({
                self.items = _newItems
                self.collectionView.insertItems(at: indexPaths)
            }, completion: { (flag) in
                completion()
            })
        }
    }

    func findMorePrimes(with completion: @escaping ([String], [IndexPath]) -> Void) {
        var reuslt: [String] = []
        DispatchQueue.global().async {
            var indexPaths: [IndexPath] = []

            for i in 0 ..< 20 {
                reuslt.append(arc4random_uniform(1000).description)
                indexPaths.append(IndexPath(item: i, section: 0))
            }

            DispatchQueue.main.async {
                completion(reuslt, indexPaths)
            }
        }
    }
}

extension CGMutablePath {
    func addCurveToPoint(_ cp1x: CGFloat, _ cp1y: CGFloat, _ cp2x: CGFloat, _ cp2y: CGFloat, _ x: CGFloat, _ y: CGFloat) {
        addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: cp1x, y: cp1y), control2: CGPoint(x: cp2x, y: cp2y))
    }
}
