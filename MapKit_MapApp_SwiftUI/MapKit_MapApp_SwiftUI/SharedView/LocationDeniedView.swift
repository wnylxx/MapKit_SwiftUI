//
//  LocationDeniedView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/22/24.
//

import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Text("설정에서 위치 권한을 켜주세요.")
        }, description: {
            Text("""
1. 설정창에 간다
2. 개인 정보 보호 및 보안
3. 위치 서비스
4. 앱 위치 권한 부여
""")
            .multilineTextAlignment(.leading)
        }, actions: {
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }) {
                Text("Open Setting")
            }
        })
    }
}

#Preview {
    LocationDeniedView()
}
