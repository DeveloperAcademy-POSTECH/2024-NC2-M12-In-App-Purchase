# 2024-NC2-M12-In-App-Purchase
애플 디벨로퍼 아카데미 3기 오전 12팀(한톨&amp;나다) 멋진 인앱 결제 NC2 프로젝트

![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M12-In-App-Purchase/assets/113565086/36dc5677-190c-41ab-a359-8fb8fef908c3)

## Hi-fi

![Frame 30](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M12-In-App-Purchase/assets/113565086/91398f3d-4e80-4018-b915-2a2b935e63ce)


## Structure

![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M12-In-App-Purchase/assets/113565086/92a2f27a-75ee-4a42-ac06-43f23e6e558b)

## StoreKit Key Concept
### Product

```swift
struct Product
```
- App Store의 제품을 표현하는 타입.
	- displayName: String
	- displayPrice: String
#### Product.currentEntitlement
- 사용자가 Product에 대한 자격이 없는 경우 `nil`.
- 비소모성 구독, 갱신되지 않는 구독 및 자동 갱신 구독에만 적용.
#### Product.PurchaseResult
- 구매 결과 타입
	- 성공하면 `VerificationResult` 를 포함.
---
### VerificationResult
```swift
@frozen
enum VerificationResult<SignedType>
```
- StoreKit 검증(verification) 결과를 설명하는 타입.
	- `Transacion`, `Product.SubscriptionInfo.RenewalInfo` `AppTransaction` 값을 자동으로 확인.
- case `verified`
	- StoreKit 자동 확인 검사 통과
- case `unverified` 
	- StoreKit 자동 확인에 실패
---
### Transaction

```swift
struct Transaction
```
- 고객이 앱에서 제품을 구매했음을 나타내는 정보. (거래)
	- 고객이 인앱 구매를 하거나 구독을 갱신할 때 마다 `Transaction`을 생성.
- 다음과 같은 거래 관련 작업을 수행하려면 `Transaction`타입을 사용하자!
	- 콘텐츠와 서비스를 잠금해제 하려면 사용자의 거래 내역(transaction history), 최신 거래(latest transaction), 현재 자격(current entitlements)을 확보.
	- transaction 프로퍼티에 접근
	- 앱에서 구매한 콘텐츠나 서비스를 제공 후 거래 완료
	- JWS 문자열 및 지원 값에 접근해 거래 정보 확인.
	- 앱이 실행되는 동안 새 Transaction 수신(Listen)
	- 앱 내에서 환불 요청 시작.
- **앱에서 Transaction 객체를 생성하지 않음!!**
	-> 대신 StoreKit은 사용자가 처음으로 앱을 시작할 떄를 포함해 최신 Transaction을 자동으로 만듬!
- 어떻게 만듬?
	1. static `all` 시퀀스에 접근해 언제든지 `Transaction`을 가져오거나 `Product`의 `latestTransaction` 속성에 접근해 제품에 대한 가장 최근 `Transaction` 반환.
	2. 사용자가 다른 기기에서 `Transaction`을 완료하면 앱이 실행되는 동안 transaction listener를 통해 새 Transaction에 대한 알림을 받습니다.
	3. `transaction`을 사용해 구독 그룹의 최신 Transaction에 액세스.
	4. 인앱 구매 성공 후 `Product.PurchaseResult.success(_:)` 를 통해 Transaction 반환.
- Transaction 정보의 가장 중요한 용도는 사용자가 어떤 인앱 구매에 대해 유료 액세스 권한을 가지고 있는지 확인 해 앱에서 콘텐츠나 서비스를 잠금해제할 수 있도록 하는 것.
- `originalPurchaseDate`: Date -> 원래 거래의 구매 날짜.
- `purchaseDate`: Date -> App Store에서 구매 또는 복원된 제품, 구독 구매 또는 만료 후 갱신에 대해 사용자 계정에 비용을 청구한 날짜.
- revocationDate: 거래를 환불하거나 가족 공유에서 취소한 날짜.
---
### static var updates: Transaction.Transactions { get }
- 앱 외부나 다른 장치에서 발생하는 Transaction을 생성하거나 업데이트할 때 내보내는 비동기 시퀀스.
	- 동일한 장치에서 인앱 구매 성공 시 `Product.PurchaseResult.success(_:)`를 통해 Transaction 반환.
	- 앱이 시작하자마자 리스너의 Transaction을 반복하는 `Task` 만들 것!

## Code

### 1. 주요 엔티티: SaleCoupon(판매용 쿠폰)
```swift
/// 판매 쿠폰
struct SaleCoupon: Identifiable {
    let id: Int
    let title: String
    let price: Decimal
    let displayPrice: String
    let target: PersonTarget
    let emoji: String
}
```

### 2. 주요 엔티티: PurchaseCoupon(구매한 쿠폰)
```swift
/// 구매한 쿠폰
/// SwiftData 사용
/// 소모성 아이템은 구매한 시점 이후로부터는
/// 앱이나 서버에서 관리 필요.
@Model
final class PurchaseCoupon: Identifiable {
    
    let couponId: Int
    let transactionId: UInt64
    
    let purchaseDate: Date
    var usedDate: Date?
    
    var isUsed: Bool
    var isRefundPending: Bool
    
    init(
        couponId: Int,
        transactionId: UInt64,
        purchaseDate: Date = .now,
        usedDate: Date? = nil,
        isUsed: Bool = false,
        isRefundPending: Bool = false
    ) {
        self.couponId = couponId
        self.transactionId = transactionId
        self.purchaseDate = purchaseDate
        self.usedDate = usedDate
        self.isUsed = isUsed
        self.isRefundPending = isRefundPending
    }
}
```

### 3. 결제 결과 반환 타입: IAPResult
```swift
/// 인앱 구매 성공 시 반환하는 구조체
struct IAPResult {
    let transactionId: UInt64
    let purchaseDate: Date
}
```

### 4. 구매 과정에서 일어날 수 있는 에러: IAPError
```swift
/// 인앱 구매 과정에서 발생할 수 있는 Error 열거형
enum IAPError: Error {
    case cannotFoundProduct
    case unverified
}
```

### 5. StoreKit - Service 객체 구현
```swift
import StoreKit

final class StoreService {

	/// Product ID
	/// 상품 ID를 들고 있음.
	/// 얘는 원래는 앱스토어에 실제 등록한 productID를 가정한 배열.
	/// 최적의 상황은 요런 productID를 백엔드 서버에서 들고 있다가
	/// 프론트에 JSON 형태로 던져주는게 최적의 상황.
	private var productIDs = ["coupon0", "coupon1", "coupon2"]
	
	/// 새로운 거래가 발생하는지 확인하고 실행하는 리스너
	var transactionListener: Task<Void, Error>?
	
	/// 전체 상품 반환
	@MainActor
	func requestProducts async -> [SaleCoupon] {}
	
	/// 구매하기
	@MainActore
	func purchase(id: Int) async throws -> Result<IAPResult, IAPError) {}
	
	/// 거래가 발생 확인 Listener
	private func listenForTransaction() -> Task<Void, Error> 
	
	/// 거래 Handling
	@MainAction
	func handle(transactionVerification result: VerificationResult<Transaction> async -> Transaction? {}
	
	/// 현재 사용자의 자격 처리
	func fetchCurrentEntitlements() async -> [Transaction] {}
}
```

### 6. StoreKit - requestProducts() 전체 상품 반환
```swift
@MainActor
func requestProducts() async -> [SaleCoupon] {
    do {
    
		    // 1. 전체 상품 조회
        let saleProducts = try await Product.products(for: productIDs)
        
        // 2. 상품 ID를 통해 SaleCoupon으로 Mapping
        let coupons = saleProducts.map {
            if let lastChar = $0.id.last,
               let id = Int(String(lastChar)) {
                return SaleCoupon(
                    id: id,
                    title: $0.displayName,
                    price: $0.price,
                    displayPrice: $0.displayPrice,
                    target: saleCoupons[id].target,
                    emoji: saleCoupons[id].emoji
                )
            }
            
            return SaleCoupon(
                id: 0,
                title: "",
                price: 0,
                displayPrice: "0",
                target: .all,
                emoji: ""
            )
        }
        
        // 3. ID를 기준으로 정렬
        return coupons.sorted { $0.id < $1.id }
    } catch {
        print(error.localizedDescription)
        return []
    }
}
```

### 7. StoreKit - purchase() 상품 구매
```swift
@MainActor
func purchase(id: Int) async throws -> Result<IAPResult, IAPError> {

		// 1. ID를 기준으로 Product
    guard let product = try await Product.products(for: ["coupon\(id)"]).first else {
        return .failure(.cannotFoundProduct)
    }
    
    
    // 2. 상품 구매 요청
    // 반환값으로 Product.PurchaseResult 타입 반환
    let result = try await product.purchase()
    
    // 3. 구매 결과에 따라 분기 처리
    switch result {
    case .success(.verified(let transaction)):
    
		    // 거래 종료
        await transaction.finish()
        return .success(
            IAPResult(
                transactionId: transaction.id,
                purchaseDate: transaction.purchaseDate
            )
        )
        
    default: return .failure(.unverified)
    }
}
```

### 8. 거래 Listener - 외부 기기나 웹사이트에서 거래 발생 시 업데이트 하는 Listener
```swift
/// Transaction Listener
private func listenForTransaction() -> Task<Void, Error> {
    
    // 1. Listen 매커니즘은 실시간으로 작업을 수행해야 함.
    // 하지만 앱은 별개로 UI 액션과 같은 다른 작업을 수행해야 하기 때문에 Task를 분리하는 것.
    return Task(priority: .background) {
        
        // 2. 지속적으로 새로운 Transaction을 모니터링하고 새로운 Transaction이 나타내면 받아옴.
        for await verificationResult in Transaction.updates {
            
            // 3. Transaction 결과에 따른 핸들링.
            await self.handle(transactionVerification: verificationResult)
        }
    }
}
```

### 9. Transacion 결과에 따른 handling
```swift
/// Transaction 결과에 따른 처리
@MainActor
@discardableResult
private func handle(transactionVerification result:
VerificationResult<Transaction>) async -> Transaction? {
    switch result {
        
        // 거래 성공!
        // transaction은 product 객체를 가지고 있지 않기 때문에 요렇게 ID 값을 이용해 불러옴.
    case .verified(let transaction):
        
        // 거래 프로세스 종료
        await transaction.finish()
        return transaction
        
        // 거래 실패.
    default: return nil
    }
}
```

### 10. 현재 사용자의 자격 처리 및 Transacion 반환
```swift
/// 현재 사용자의 자격 처리
func fetchCurrentEntitlements() async -> [Transaction] {
    
    var transactions: [Transaction] = []
    
    // currentEntitlements
    // 인터넷에 연결되어 있는 경우 최신 Transaction을 검색
    // 인터넷 연결이 없으면 로컬로 캐시된 데이터를 가져옴.
    // + 인터넷 연결이 복원되면 거래가 자동으로 기기에 동기화.
    for await result in Transaction.currentEntitlements {
        guard let transaction = await self.handle(transactionVerification: result) else {
            return []
        }
        
        transactions.append(transaction)
    }
    
    return transactions
}
```

### 11. 환불하기
```swift
RefundView()
  .refundRequestSheet(
      for: selectedTransactionID ?? 0,
      isPresented: $isRefundSheetPresented
  )
```
