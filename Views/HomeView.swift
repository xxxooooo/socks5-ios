//
//  HomeView.swift
//  Socks5
//
//  Created by ByteDance on 2025/2/6.
//

import SwiftUI
import HevSocks5Server

struct HomeView: View {

    @State private var workersText: String = "4"
    @State private var listenAddrText: String = "::"
    @State private var listenPortText: String = "1080"
    @State private var udpListenAddrText: String = ""
    @State private var udpListenPortText: String = "1080"
    @State private var bindIpv4AddrText: String = "0.0.0.0"
    @State private var bindIpv6AddrText: String = "::"
    @State private var bindIfaceText: String = ""
    @State private var authUserText: String = ""
    @State private var authPassText: String = ""
    @State private var listenIpv6OnlyToggle: Bool = false
    @State private var isRunning: Bool = false

    var body: some View {
        GeometryReader { geometry in
            // ScrollView {
                VStack(spacing: 8) {
                    Text("Workers:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $workersText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Listen Address:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $listenAddrText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Listen Port:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $listenPortText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("UDP Listen Address:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Optional", text: $udpListenAddrText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("UDP Listen Port:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $udpListenPortText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Bind IPv4 Address:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $bindIpv4AddrText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Bind IPv6 Address:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $bindIpv6AddrText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Bind Interface:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Optional", text: $bindIfaceText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Auth Username:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Optional", text: $authUserText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Text("Auth Password:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .font(Font.system(.body, design: .serif))
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    SecureField("Optional", text: $authPassText)
                        .padding(.top, 0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .disabled(isRunning)

                    Toggle(isOn: $listenIpv6OnlyToggle) {
                        Text("Listen IPv6 only")
                            .font(.caption)
                            .fontWeight(.medium)
                            .font(Font.system(.body, design: .serif))
                    }
                    .toggleStyle(SwitchToggleStyle())
                    .frame(maxWidth: .infinity)
                    .disabled(isRunning)

                    HStack {
                        Button(action: {
                            isRunning = true
                            DispatchQueue.global().async {
                                let conf = """
                                    main:
                                      workers: \(workersText)
                                      port: \(listenPortText)
                                      listen-address: '\(listenAddrText)'
                                      udp-port: \(udpListenPortText)
                                      udp-listen-address: '\(udpListenAddrText)'
                                      listen-ipv6-only: \(listenIpv6OnlyToggle)
                                      bind-address-v4: '\(bindIpv4AddrText)'
                                      bind-address-v6: '\(bindIpv6AddrText)'
                                      bind-interface: '\(bindIfaceText)'
                                    auth:
                                      username: '\(authUserText)'
                                      password: '\(authPassText)'
                                    """
                                let _ = hev_socks5_server_main_from_str(conf, UInt32(strlen(conf)))
                                isRunning = false
                            }
                        }) {
                            Text("Start")
                            .font(.caption)
                            .fontWeight(.medium)
                            .font(Font.system(.body, design: .serif))
                            .padding()
                            .cornerRadius(10)
                        }
                        .disabled(isRunning)
                        .frame(maxWidth: .infinity)
                        Button(action: {
                            hev_socks5_server_quit ()
                        }) {
                            Text("Stop")
                            .font(.caption)
                            .fontWeight(.medium)
                            .font(Font.system(.body, design: .serif))
                            .padding()
                            .cornerRadius(10)
                        }
                        .disabled(!isRunning)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                }
                .padding()
//            }
            .frame(maxHeight: geometry.size.height - 49)
         }
    }
}

#Preview {
    HomeView()
}
