import Foundation

public enum PostboxViewKey: Hashable {
    case itemCollectionInfos(namespaces: [ItemCollectionId.Namespace])
    case itemCollectionIds(namespaces: [ItemCollectionId.Namespace])
    case itemCollectionInfo(id: ItemCollectionId)
    case peerChatState(peerId: PeerId)
    case orderedItemList(id: Int32)
    case accessChallengeData
    case preferences(keys: Set<ValueBoxKey>)
    case globalMessageTags(globalTag: GlobalMessageTags, position: MessageIndex, count: Int, groupingPredicate: ((Message, Message) -> Bool)?)
    
    public var hashValue: Int {
        switch self {
            case .itemCollectionInfos:
                return 0
            case .itemCollectionIds:
                return 1
            case let .peerChatState(peerId):
                return peerId.hashValue
            case let .itemCollectionInfo(id):
                return id.hashValue
            case let .orderedItemList(id):
                return id.hashValue
            case .accessChallengeData:
                return 2
            case .preferences:
                return 3
            case .globalMessageTags:
                return 4
        }
    }
    
    public static func ==(lhs: PostboxViewKey, rhs: PostboxViewKey) -> Bool {
        switch lhs {
            case let .itemCollectionInfos(lhsNamespaces):
                if case let .itemCollectionInfos(rhsNamespaces) = rhs, lhsNamespaces == rhsNamespaces {
                    return true
                } else {
                    return false
                }
            case let .itemCollectionIds(lhsNamespaces):
                if case let .itemCollectionIds(rhsNamespaces) = rhs, lhsNamespaces == rhsNamespaces {
                    return true
                } else {
                    return false
                }
            case let .itemCollectionInfo(id):
                if case .itemCollectionInfo(id) = rhs {
                    return true
                } else {
                    return false
                }
            case let .peerChatState(peerId):
                if case .peerChatState(peerId) = rhs {
                    return true
                } else {
                    return false
                }
            case let .orderedItemList(id):
                if case .orderedItemList(id) = rhs {
                    return true
                } else {
                    return false
                }
            case .accessChallengeData:
                if case .accessChallengeData = rhs {
                    return true
                } else {
                    return false
                }
            case let .preferences(lhsKeys):
                if case let .preferences(rhsKeys) = rhs, lhsKeys == rhsKeys {
                    return true
                } else {
                    return false
                }
            case let .globalMessageTags(globalTag, position, count, _):
                if case .globalMessageTags(globalTag, position, count, _) = rhs {
                    return true
                } else {
                    return false
                }
        }
    }
}

func postboxViewForKey(postbox: Postbox, key: PostboxViewKey) -> MutablePostboxView {
    switch key {
        case let .itemCollectionInfos(namespaces):
            return MutableItemCollectionInfosView(postbox: postbox, namespaces: namespaces)
        case let .itemCollectionIds(namespaces):
            return MutableItemCollectionIdsView(postbox: postbox, namespaces: namespaces)
        case let .itemCollectionInfo(id):
            return MutableItemCollectionInfoView(postbox: postbox, id: id)
        case let .peerChatState(peerId):
            return MutablePeerChatStateView(postbox: postbox, peerId: peerId)
        case let .orderedItemList(id):
            return MutableOrderedItemListView(postbox: postbox, collectionId: id)
        case .accessChallengeData:
            return MutableAccessChallengeDataView(postbox: postbox)
        case let .preferences(keys):
            return MutablePreferencesView(postbox: postbox, keys: keys)
        case let .globalMessageTags(globalTag, position, count, groupingPredicate):
            return MutableGlobalMessageTagsView(postbox: postbox, globalTag: globalTag, position: position, count: count, groupingPredicate: groupingPredicate)
    }
}
